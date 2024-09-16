from typing import List, Dict
from pydantic import BaseModel
import pandas as pd
from fastapi import FastAPI, HTTPException
from enum import Enum

# Grade to GPA mapping
grade_to_gpa = {
    "A+": 4.00, "A": 4.00, "A-": 3.70,
    "B+": 3.30, "B": 3.00, "B-": 2.70,
    "C+": 2.30, "C": 2.00, "C-": 1.70,
    "D+": 1.30, "D": 1.00, "F": 0.00
}

# Define the enum for student levels
class StudentLevel(str, Enum):
    FRESHMAN = "Freshman"
    SOPHOMORE = "Sophomore"
    JUNIOR = "Junior"
    SENIOR = "Senior"

# Define the classes with the "HD" prefix
class HDCourse(BaseModel):
    course_id: str
    course_name: str
    course_section: int
    credit: int
    final_grade: str = "N/A"  # Default value for final_grade
    gpa: float = 0.00  # Calculated GPA for the course

    def calculate_gpa(self):
        if self.final_grade in grade_to_gpa:
            self.gpa = grade_to_gpa[self.final_grade] 

class HDTerm(BaseModel):
    term_name: str
    courses: List[HDCourse] = []
    term_gpa: float = 0.00  # Calculated GPA for the term
    total_credits: int = 0   # Total credits taken in the term

    def calculate_gpa(self):
            valid_courses = [course for course in self.courses if course.final_grade != "N/A"]
            
            self.total_credits = sum(course.credit for course in valid_courses)
            total_gpa_points = sum(course.gpa * course.credit for course in valid_courses)
            
            if self.total_credits > 0:
                self.term_gpa = total_gpa_points / self.total_credits
            else:
                self.term_gpa = 0.00  # If no valid courses, GPA remains 0.00

class HDYear(BaseModel):
    year: int
    terms: List[HDTerm] = []
    year_gpa: float = 0.00  # Calculated GPA for the year
    total_credits: int = 0   # Total credits taken in the year

    def calculate_gpa(self):
        for term in self.terms:
            term.calculate_gpa()
        self.total_credits = sum(term.total_credits for term in self.terms)
        total_gpa_points = sum(term.term_gpa * term.total_credits for term in self.terms)
        if self.total_credits > 0:
            self.year_gpa = total_gpa_points / self.total_credits

class HDStudent(BaseModel):
    people_id: int
    program: str
    degree: str
    curriculum: str
    college: str
    department: str
    years: List[HDYear] = []
    total_gpa: float = 0.00  # Calculated total GPA for the student
    total_credits: int = 0
    level: StudentLevel = StudentLevel.FRESHMAN

    def calculate_gpa(self):
        total_credits = 0
        total_gpa_points = 0.0

        for year in self.years:
            year.calculate_gpa()
        total_credits=  sum(year.total_credits for year in self.years)
        total_gpa_points = sum(year.year_gpa * year.total_credits for year in self.years)
        if total_credits > 0:
            self.total_gpa = total_gpa_points / total_credits
            self.total_credits = total_credits
            self.level = self.determine_student_level()

    def determine_student_level(self):
        if self.total_credits >= 96:
            return StudentLevel.SENIOR
        elif self.total_credits >= 63:
            return StudentLevel.JUNIOR
        elif self.total_credits >= 28:
            return StudentLevel.SOPHOMORE
        else:
            return StudentLevel.FRESHMAN

# Function to parse data from the CSV
# Function to parse data from the CSV with handling for missing department values
def parse_data_from_csv(file_path: str, valid_subtypes: List[str]) -> List[HDStudent]:
    data = pd.read_csv(file_path)
    students = {}

    for _, entry in data.iterrows():
        if entry['Course_Sub_Type'] not in valid_subtypes:
            continue

        people_id = entry['PEOPLE_ID']
        if people_id not in students:
            # Handle missing or NaN values in the department field
            department = entry['department'] if pd.notna(entry['department']) else "Unknown"

            students[people_id] = HDStudent(
                people_id=people_id,
                program=entry['Program'],
                degree=entry['degree'],
                curriculum=entry['curriculum'],
                college=entry['college'],
                department=department,  # Use the default "Unknown" for NaN values
                years=[]
            )

        year = next((y for y in students[people_id].years if y.year == entry['Year']), None)
        if not year:
            year = HDYear(year=entry['Year'], terms=[])
            students[people_id].years.append(year)

        term = next((t for t in year.terms if t.term_name == entry['Term']), None)
        if not term:
            term = HDTerm(term_name=entry['Term'], courses=[])
            year.terms.append(term)

        final_grade = entry['FINAL_GRADE'] if pd.notna(entry['FINAL_GRADE']) else "N/A"

        try:
            course_section = int(entry['Course_Section'])
        except ValueError:
            print(f"Skipping course with invalid course_section: {entry['Course_Section']}")
            continue

        course = HDCourse(
            course_id=entry['Course_ID'],
            course_name=entry['Course_Sub_Type'],
            course_section=course_section,
            credit=entry['CREDIT'],
            final_grade=final_grade
        )
        course.calculate_gpa()
        term.courses.append(course)

    # Calculate GPAs and student levels
    for student in students.values():
        student.calculate_gpa()

    return list(students.values())


