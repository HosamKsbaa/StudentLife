import csv
import json
import os
from typing import List
from pydantic import BaseModel, Field
from typing import Optional


class Course(BaseModel):
    id: str
    prereqs: List['Course'] = []
    for_prereqs: List['Course'] = []
    credits: int
    is_available: bool
    credit_requirement: int  # New attribute for credit requirement


# This is necessary because 'Course' is a forward reference in the definition of 'Course'
Course.__annotations__ = {}

class Student(BaseModel):
    id: str
    courses_taken: List[Course] = []
    def calculate_total_credits(self):
        return sum(course.credits for course in self.courses_taken)
class CheckObject(BaseModel):
    CheckType: str
    message: str
    passed: bool

class CourseState(BaseModel):
    Course: Course
    student: Student
    accepted: Optional[bool] = True
    courses_Checks: List[CheckObject] = []

    

    
def read_course_data(file_path):
    # Read the file content into a list of dictionaries
    with open(file_path, 'r') as file:
        reader = csv.DictReader(file)
        course_data_list = list(reader)

    courses = {
    row['CourseID']: Course(
        id=row['CourseID'],
        credits=int(row['Num credits']),
        is_available=bool(int(row['IsitAvilable'])),  # Convert 1 to True, 0 to False
        credit_requirement=int(row['CreditRequirement'])  # Replace with the actual column name
    ) for row in course_data_list
}

    # Add prerequisites and update for_prereqs list
    for row in course_data_list:
        course = courses[row['CourseID']]
        course.prereqs.extend(courses[row[f'PreReq{i}']] for i in range(1, 4) if row[f'PreReq{i}'] in courses)

    # Populate the for_prereqs field
    for course in courses.values():
        for prereq in course.prereqs:
            prereq.for_prereqs.append(course)

    return courses


def read_student_data(file_path, courses, mapping_file_path):
    # Read and process the mapping file
    course_name_to_id = {}
    with open(mapping_file_path, 'r') as mapping_file:
        reader = csv.DictReader(mapping_file)
        for row in reader:
            course_name_in_student_file = row['CourseName']  # Adjust the key according to your file's column name
            course_id = row['Final']  # Adjust the key according to your file's column name
            course_name_to_id[course_name_in_student_file] = course_id

    # Initialize an empty dictionary to store student data
    students = {}

    # Open the CSV file for reading student data
    with open(file_path, 'r') as file:
        reader = csv.DictReader(file)
        for row in reader:
            student_id = row['StudentID']  # Adjust the key according to your file's column name
            courses_taken = []

            for course_name, taken in row.items():
                if course_name != 'StudentID' and int(taken) >= 1:
                    course_id = course_name_to_id.get(course_name)
                    if course_id and course_id in courses:
                        courses_taken.append(courses[course_id])

            students[student_id] = Student(id=student_id, courses_taken=courses_taken)

    return students

def recommend_courses(students, courses, output_file):
    recommendations = {}

    for student in students.values():
        available_courses: List[CourseState] = filter_available_courses(student, courses)
        rejected_courses: List[CourseState] = list(filter(lambda course: not course.accepted, available_courses))
        accepted_courses: List[CourseState] = list(filter(lambda course: course.accepted, available_courses))

        student_recommendations = []

        for course_state in accepted_courses:
            recommendation =  course_state.Course.id

            

            student_recommendations.append(recommendation)

        recommendations[student.id] = {
            'AcceptedCourses': student_recommendations,
            'RejectedCourses': [{
                'CourseID': course_state.Course.id,
                'Reasons': [{
                    'CheckType': check.CheckType,
                    'Message': check.message
                } for check in course_state.courses_Checks if not check.passed]
            } for course_state in rejected_courses]
        }

    with open(output_file, 'w') as json_file:
        json.dump(recommendations, json_file, indent=2)
def filter_available_courses(student, courses):
    taken_course_ids = {course.id for course in student.courses_taken}
    
    def is_course_available_for_term(courseState: CourseState):
        return courseState.Course.is_available
    
    def meets_prerequisites(courseState: CourseState):
        taken_course_ids = {course.id for course in courseState.student.courses_taken}

        # List to store prerequisites for the current course
        prerequisites = []

        for prereq in courseState.Course.prereqs:
            if prereq.id not in taken_course_ids:
                prerequisites.append(prereq.id)

        if prerequisites:
            message = f"Prerequisites not met for course {courseState.Course.id}. Required prerequisites: {', '.join(prerequisites)}"
            courseState.accepted = False
        else:
            message = f"Prerequisites met for course {courseState.Course.id}"

        courseState.courses_Checks.append(CheckObject(
            CheckType="Prerequisites",
            message=message,
            passed=not prerequisites
        ))

    def has_not_taken_course(courseState: CourseState):
        if courseState.Course.id in taken_course_ids:
            message = f"Course {courseState.Course.id} has already been taken"
            passed = False
            courseState.accepted = False
        else:
            message = f"Course {courseState.Course.id} has not been taken before"
            passed = True

        courseState.courses_Checks.append(CheckObject(
            CheckType="NotTakenBefore",
            message=message,
            passed=passed
        ))
        
    def satisfies_credit_requirement(courseState: CourseState):
        if courseState.Course.credit_requirement > courseState.student.calculate_total_credits():
            message = f"Insufficient credits for course {courseState.Course.id}"
            passed = False
            courseState.accepted=False

        else:
            message = f"Credit requirement met for course {courseState.Course.id}"
            passed = True

        courseState.courses_Checks.append(CheckObject(
            CheckType="CreditRequirement",
            message=message,
            passed=passed
        ))

    available_courses: list[CourseState] = []
    for course in courses.values():
        # Create CourseState object for each course with references to the Course and Student models
        course_state = CourseState(Course=course, student=student)
        
        # Perform checks and add results to CourseState
        if is_course_available_for_term(course_state):
            has_not_taken_course(course_state)
            meets_prerequisites(course_state)
            satisfies_credit_requirement(course_state)
            available_courses.append(course_state)

        
        # Determine overall acceptance status
        
    return available_courses

def main():
    student_data_file = "data/student_courses.csv"
    course_data_file = "data/prerequisites.csv"
    output_file = "output/recommended_courses.json"
    os.makedirs(os.path.dirname(output_file), exist_ok=True)


    # Load course data, creating a dictionary of Course objects
    courses = read_course_data(course_data_file)

    # Load student data, creating a dictionary of Student objects
    students = read_student_data(student_data_file, courses)

    # Make course recommendations for each student
    recommend_courses(students, courses, output_file)

if __name__ == "__main__":
    main()
