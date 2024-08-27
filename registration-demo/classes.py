from typing import List
from pydantic import BaseModel
import pandas as pd
from fastapi import FastAPI, HTTPException

# Define the classes with the "HD" prefix
class HDCourse(BaseModel):
    course_id: str
    course_name: str
    course_section: int
    credit: int
    final_grade: str = "N/A"  # Default value for final_grade

class HDTerm(BaseModel):
    term_name: str
    courses: List[HDCourse] = []

class HDYear(BaseModel):
    year: int
    terms: List[HDTerm] = []

class HDStudent(BaseModel):
    people_id: int
    program: str
    degree: str
    curriculum: str
    college: str
    department: str
    years: List[HDYear] = []

# Function to parse data from the CSV
def parse_data_from_csv(file_path: str, valid_subtypes: List[str]) -> List[HDStudent]:
    data = pd.read_csv(file_path)
    students = {}

    for _, entry in data.iterrows():
        if entry['Course_Sub_Type'] not in valid_subtypes:
            continue

        people_id = entry['PEOPLE_ID']
        if people_id not in students:
            students[people_id] = HDStudent(
                people_id=people_id,
                program=entry['Program'],
                degree=entry['degree'],
                curriculum=entry['curriculum'],
                college=entry['college'],
                department=entry['department'],
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

        # Handle NaN values by filling with a default or skipping
        final_grade = entry['FINAL_GRADE'] if pd.notna(entry['FINAL_GRADE']) else "N/A"

        try:
            # Attempt to convert course_section to an integer, handle exceptions
            course_section = int(entry['Course_Section'])
        except ValueError:
            # Log the error or skip the entry
            print(f"Skipping course with invalid course_section: {entry['Course_Section']}")
            continue

        course = HDCourse(
            course_id=entry['Course_ID'],
            course_name=entry['Course_Sub_Type'],
            course_section=course_section,
            credit=entry['CREDIT'],
            final_grade=final_grade
        )
        term.courses.append(course)

    return list(students.values())

# Load the student data from the CSV
students_data = parse_data_from_csv("data/Student Grade/CombinedActiveStudents2.csv", valid_subtypes=["LECT"])

# FastAPI app definition
app = FastAPI()

@app.get("/student/{student_id}", response_model=HDStudent)
async def get_student(student_id: int):
    student = next((s for s in students_data if s.people_id == student_id), None)
    if student is None:
        raise HTTPException(status_code=404, detail="Student not found")
    return student

# Run the FastAPI app
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
