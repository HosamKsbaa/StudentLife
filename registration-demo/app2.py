import random
from typing import Dict, List, Optional, Union
from pydantic import BaseModel
import csv
import json
import os
import requests
from fastapi import FastAPI, HTTPException
from fastapi.responses import PlainTextResponse
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from fastapi import FastAPI, HTTPException, Query


from CompetenciesLogic.CompetenciesApi import  create_student, load_student_data
from CompetenciesLogic.models import CompetenciesStudent, StudentResponse


class Category(BaseModel):
    name: str
    required_credits: int
    sub_of: Optional[str]

class Reason(BaseModel):
    check_type: str
    pass_or_fail: bool
    state_description: str
    reference_to_prerequisite: Optional['Prerequisite'] = None

class Prerequisite(BaseModel):
    course: Optional['Course'] = None

    def pass_check(self, student: 'Student') -> Reason:
        if self.course:
            if self.course in student.courses_taken:
                return Reason(
                    check_type="PrerequisiteCheck",
                    pass_or_fail=True,
                    state_description=f"Student has passed the prerequisite course: {self.course.name}",
                    reference_to_prerequisite=self
                )
            else:
                return Reason(
                    check_type="PrerequisiteCheck",
                    pass_or_fail=False,
                    state_description=f"Student has not taken or not passed the prerequisite course: {self.course.code} {self.course.name}",
                    reference_to_prerequisite=self
                )
        else:
            return Reason(
                check_type="PrerequisiteCheck",
                pass_or_fail=False,
                state_description="Prerequisite course information is missing",
                reference_to_prerequisite=self
            )

class CoursePreqest(Prerequisite):
    course: 'Course'

    def pass_check(self, student: 'Student') -> Reason:
        if not self.course:
            return Reason(
                check_type="CoursePrerequisiteCheck",
                pass_or_fail=False,
                state_description="Prerequisite course information is missing",
                reference_to_prerequisite=self
            )

        for prereq in self.course.prerequisites:
            if prereq.course and not student.has_passed_course(prereq.course):
                return Reason(
                    check_type="CoursePrerequisiteCheck",
                    pass_or_fail=False,
                    state_description=f"Student has not taken or not passed the prerequisite course: {prereq.course.code} {prereq.course.name}",
                    reference_to_prerequisite=prereq
                )

        return Reason(
            check_type="CoursePrerequisiteCheck",
            pass_or_fail=True,
            state_description="Student has passed all prerequisite courses",
            reference_to_prerequisite=self
        )

class Other(Prerequisite):
    description: str

class Course(BaseModel):
    code: str
    originalCode: str
    name: str
    category: Category
    prerequisites: List[Union[CoursePreqest, Other]] = []
    is_available_this_term: bool
    credits: int
    typical_year: int
    term: int
    for_prereqs: List['Course'] = []

    def serialize_for_json(self):
        return {
            "code": self.code,
            "name": self.name,
            "originalCode": self.originalCode,
            'credits': self.credits,
            "category": self.category.name if self.category else None,
            "is_available_this_term": self.is_available_this_term,
            "typical_year": self.typical_year,
            "term": self.term,
        }

class Student(BaseModel):
    id: str
    courses_taken: List[Course] = []

    def get_current_credit(self) -> int:
        return sum(course.category.required_credits for course in self.courses_taken)

    def has_passed_course(self, course: Course) -> bool:
        return course in self.courses_taken

class DependencyTree(BaseModel):
    code: str
    name: str
    typical_year: int
    term: int
    category: str
    credits: int
    dependencies: List['DependencyTree'] = []

class CourseInfo(BaseModel):
    code: str
    name: str
    originalCode: str
    credits: int
    expectedGrade :float
    category: str
    is_available_this_term: bool
    typical_year: int
    term: int
    category_progress: str
    dependent_courses_count: int
    dependency_tree: DependencyTree

class IneligibleCourse(BaseModel):
    course: CourseInfo
    reasons: List[str]


class StudentData(BaseModel):
    eligible_courses: Dict[str, List[CourseInfo]]
    ineligible_courses: Dict[str, List[IneligibleCourse]]
    category_progress: Dict[str, Dict[str, int]]

class RAResponse(BaseModel):
    id: str
    student_data: StudentData
    graph_output: str


def load_categories(file_path: str) -> List[Category]:
    categories = []
    with open(file_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            categories.append(Category(
                name=row['Subject Area'],
                required_credits=int(row['Number of Credits']),
                sub_of=row.get('SubOf')
            ))
    return categories

def parse_prerequisites(course_row, courses_dict):
    prerequisites = []

    if course_row['preq corses']:
        course_preq_codes = course_row['preq corses'].split(',')
        for code in course_preq_codes:
            if code in courses_dict:
                prerequisites.append(CoursePreqest(course=courses_dict[code]))

    if course_row['preq other']:
        prerequisites.append(Other(description=course_row['preq other']))

    return prerequisites

def load_courses(file_path: str, categories: List[Category]) -> List[Course]:
    category_dict = {category.name: category for category in categories}
    courses = []
    courses_dict = {}

    with open(file_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        course_rows = [row for row in reader]

    for row in course_rows:
        category_name = row['Categories']
        category = category_dict.get(category_name)

        if category is None:
            print(f"Warning: Category '{category_name}' not found. Skipping course '{row['Name']}'")
            continue

        is_available = row['Avilable this term '].strip().lower() == '1'
        typical_year = int(row['Year'])
        term = int(row['Semester'])
        credits = int(row['credits'])

        new_course = Course(
            credits=credits,
            originalCode=row['Code'],
            code=row['Code'],
            name=row['Name'],
            category=category,
            prerequisites=[],
            is_available_this_term=is_available,
            typical_year=typical_year,
            term=term,
            for_prereqs=[]
        )
        courses_dict[new_course.code] = new_course
        courses.append(new_course)

    for row in course_rows:
        course = courses_dict.get(row['Code'])
        if course:
            course.prerequisites = parse_prerequisites(row, courses_dict)

    for course in courses:
        for potential_dependent in courses:
            if course in [prereq.course for prereq in potential_dependent.prerequisites if isinstance(prereq, CoursePreqest)]:
                course.for_prereqs.append(potential_dependent)

    return courses

def load_course_mapping(file_path: str) -> dict:
    mapping = {}
    with open(file_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            mapping[row['StudentCourseCode']] = row['CourseCode']
    return mapping

def load_students(file_path: str, courses: List[Course], mapping: dict) -> List[Student]:
    course_dict = {course.code: course for course in courses}
    students = []
    with open(file_path, mode='r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            student_courses = []
            for student_course_code, value in row.items():
                if student_course_code != 'StudentID':
                    if value.strip().isdigit() and int(value.strip()) >= 1:
                        mapped_course_code = mapping.get(student_course_code)
                        if mapped_course_code in course_dict:
                            x = course_dict[mapped_course_code]
                            x.originalCode = student_course_code
                            student_courses.append(x)
                        else:
                            print(f"Warning: Course code '{student_course_code}' (mapped to '{mapped_course_code}') not found in courses.")

            students.append(Student(
                id=row['StudentID'],
                courses_taken=student_courses
            ))

    return students

def calculate_category_credits(student: Student, categories: List[Category]) -> dict:
    credits_earned = {category.name: 0 for category in categories}
    for course in student.courses_taken:
        if course.category:
            credits_earned[course.category.name] += course.credits
    return credits_earned

def build_dependency_tree(course: Course) -> DependencyTree:
    tree = DependencyTree(
        code=course.code,
        name=course.name,
        typical_year=course.typical_year,
        term=course.term,
        category=course.category.name if course.category else "Uncategorized",
        credits=course.credits,
        dependencies=[]
    )
    for dependent_course in course.for_prereqs:
        tree.dependencies.append(build_dependency_tree(dependent_course))
    return tree

def get_eligible_courses(student: Student, courses: List[Course], categories: List[Category]) -> dict:
    eligible_courses = {}
    ineligible_courses = {}
    category_credits = calculate_category_credits(student, categories)

    for course in courses:
        if not course.is_available_this_term:
            continue

        if course in student.courses_taken:
            continue

        category_name = course.category.name if course.category else "Uncategorized"
        required_credits = course.category.required_credits if course.category else 0
        earned_credits = category_credits.get(category_name, 0)
        credits_remaining = required_credits - earned_credits

        dependent_courses_count = len(course.for_prereqs)

        if credits_remaining <= 0:
            if category_name not in ineligible_courses:
                ineligible_courses[category_name] = []
            reason = f"Category '{category_name}' credit requirement already fulfilled."
            ineligible_courses[category_name].append({
                'course': course.serialize_for_json(),
                'reasons': [reason]
            })
            continue

        can_take = True
        reasons = []

        for prereq in course.prerequisites:
            reason = prereq.pass_check(student)
            if not reason.pass_or_fail:
                can_take = False
                reasons.append(reason.state_description)

        if can_take:
            if category_name not in eligible_courses:
                eligible_courses[category_name] = []
            course_info = course.serialize_for_json()
            course_info['category_progress'] = f"{earned_credits}/{required_credits} credits completed. Can take up to {credits_remaining} more credits."
            course_info['dependent_courses_count'] = dependent_courses_count
            course_info['dependency_tree'] = build_dependency_tree(course)
            eligible_courses[category_name].append(course_info)
        else:
            if category_name not in ineligible_courses:
                ineligible_courses[category_name] = []
            ineligible_courses[category_name].append({
                'course': course.serialize_for_json(),
                'reasons': reasons
            })

    return {'eligible_courses': eligible_courses, 'ineligible_courses': ineligible_courses}

def create_dependency_graph(eligible_courses):
    graph = "graph TD\n"
    added_nodes = set()

    def add_course_with_dependencies(course, is_root=True):
        nonlocal graph
        if course['code'] not in added_nodes:
            course_label = f"{course['code']}[\"{course['name']} \\n {course['category']} |\\nYear: {course['typical_year']} Term: {course['term']}\\n Credits: {course['credits']}\"]"
            graph += f"    {course_label}\n"
            added_nodes.add(course['code'])

        if is_root:
            for dependency in course['dependency_tree'].dependencies:
                graph += f"    {course['code']} --> {dependency.code}\n"
                add_course_with_dependencies(dependency.dict(), is_root=False)

    for category_courses in eligible_courses.values():
        for course in category_courses:
            if len(course['dependency_tree'].dependencies) > 0:
                add_course_with_dependencies(course)

    return graph

def calculate_category_progress(student: Student, categories: List[Category]) -> dict:
    progress = {category.name: {'earned': 0, 'required': category.required_credits} for category in categories}
    for course in student.courses_taken:
        if course.category and course.category.name in progress:
            progress[course.category.name]['earned'] += course.credits
    return progress

def fetch_predicted_grades(student_id, courses):
    # Set the seed using thh student ID to make the predictions repeatable
    random.seed(student_id)
    
    predicted_grades = {course: round(random.uniform(2.5, 4.0), 2) for course in courses}
    
    return predicted_grades

def write_course_info_to_md_file(student_id, student_data, file_path, mermaid_graph):
    with open(file_path, 'w') as file:
        file.write(f"# Progress Report for Student ID: {student_id}\n\n")
        file.write("## Category Progress\n")
        for category, progress in student_data['category_progress'].items():
            file.write(f"- **{category}**: {progress['earned']}/{progress['required']} credits completed\n")
        file.write("\n")

        file.write("## Eligible Courses\n")
        for category, courses in student_data['eligible_courses'].items():
            file.write(f"### {category}\n")
            for course in courses:
                predicted_grade_data = fetch_predicted_grades(student_id=student_id, courses=[course['originalCode']])
                predicted_grade = predicted_grade_data.get(course['code'], "N/A")

                if predicted_grade != "N/A" and isinstance(predicted_grade, (int, float)):
                    predicted_grade = round(predicted_grade, 2)

                file.write(f"- **{course['code']} {course['name']}** (Credits: {course['credits']}, Expected Grade: {predicted_grade})\n")
                file.write(f"  - Year: {course['typical_year']}, Term: {course['term']}\n")
            file.write("\n")

        file.write("## Dependency Graph\n")
        file.write("```mermaid\n")
        file.write(mermaid_graph)
        file.write("\n```\n")

        file.write("## Ineligible Courses\n")
        for category, courses in student_data['ineligible_courses'].items():
            file.write(f"### {category}\n")
            for course in courses:
                file.write(f"- **{course['course']['code']} {course['course']['name']}**\n")
                file.write("  - Reasons:\n")
                for reason in course['reasons']:
                    file.write(f"    - {reason}\n")
            file.write("\n")

def process_student_data(student_id: str):
    categories_file_path = "data/prerequisites - Categories.csv"
    courses_file_path = "data/prerequisites - Courses (1).csv"
    mapping_file_path = "data/prerequisites - Maping (1).csv"
    students_file_path = "data/prerequisites - Student.csv"

    categories = load_categories(categories_file_path)
    courses = load_courses(courses_file_path, categories)
    mapping = load_course_mapping(mapping_file_path)
    students = load_students(students_file_path, courses, mapping)

    student = next((student for student in students if student.id == student_id), None)
    if student is None:
        raise HTTPException(status_code=404, detail="Student not found")

    course_info = get_eligible_courses(student, courses, categories)
    student_data = {
        'eligible_courses': course_info['eligible_courses'],
        'ineligible_courses': course_info['ineligible_courses'],
        'category_progress': calculate_category_progress(student, categories)
    }
    graph_output = create_dependency_graph(student_data['eligible_courses'])

    return student, student_data, graph_output



app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/student/{student_id}/progress", response_class=PlainTextResponse)
async def get_student_progress(student_id: str):
    student, student_data, graph_output = process_student_data(student_id)

    md_file_path = f'output/student_{student_id}_progress.md'
    write_course_info_to_md_file(student.id, student_data, md_file_path, graph_output)

    with open(md_file_path, 'r', encoding='utf-8') as file:
        markdown_content = file.read()

    os.remove(md_file_path)

    return markdown_content

@app.get("/student/{student_id}/progress2", response_model=RAResponse)
async def get_student_progress2(student_id: str):
    student, student_data, graph_output = process_student_data(student_id)

    def build_course_info(course_json):
        predicted_grade_data = fetch_predicted_grades(student_id=student_id, courses=[course_json['originalCode']])
        predicted_grade = predicted_grade_data.get(course_json['originalCode'], None)

        if predicted_grade is not None and isinstance(predicted_grade, (int, float)):
            predicted_grade = round(predicted_grade, 2)

        return CourseInfo(
            code=course_json['code'],
            name=course_json['name'],
            originalCode=course_json['originalCode'],
            credits=course_json['credits'],
            category=course_json['category'],
            is_available_this_term=course_json['is_available_this_term'],
            typical_year=course_json['typical_year'],
            term=course_json['term'],
            expectedGrade=predicted_grade,  # Use None if no valid predicted grade is available
            category_progress=course_json.get('category_progress', ''),
            dependent_courses_count=course_json.get('dependent_courses_count', 0),
            dependency_tree=build_dependency_tree_from_json(course_json.get('dependency_tree', {}))
        )



    def build_dependency_tree_from_json(dependency_tree_json):
        if isinstance(dependency_tree_json, dict):
            return DependencyTree(
                code=dependency_tree_json.get('code', ''),
                name=dependency_tree_json.get('name', ''),
                typical_year=dependency_tree_json.get('typical_year', 0),
                term=dependency_tree_json.get('term', 0),
                category=dependency_tree_json.get('category', ''),
                credits=dependency_tree_json.get('credits', 0),
                dependencies=[
                    build_dependency_tree_from_json(dep)
                    for dep in dependency_tree_json.get('dependencies', [])
                ]
            )
        elif isinstance(dependency_tree_json, DependencyTree):
            return dependency_tree_json
        else:
            raise ValueError(f"Unsupported type for dependency_tree_json: {type(dependency_tree_json)}")

    return RAResponse(
        id=student_id,
        student_data=StudentData(
            eligible_courses={
                category: [build_course_info(course) for course in courses]
                for category, courses in student_data['eligible_courses'].items()
            },
            ineligible_courses={
                category: [
                    IneligibleCourse(
                        course=build_course_info(reason['course']),
                        reasons=reason['reasons']
                    ) for reason in reasons
                ] for category, reasons in student_data['ineligible_courses'].items()
            },
            category_progress=student_data['category_progress']
        ),
        graph_output=graph_output
    )

students_data:CompetenciesStudent = load_student_data('data/Competencies/CompetenciesDataTempStu.csv')
df = load_student_data('data/Competencies/CompetenciesDataTempStu.csv')

@app.get("/student/{student_name}", response_model=StudentResponse)
def read_student(student_name: str, benchmarks: List[str] = Query(None)):
    
    # Load the specified student
    try:
        student = create_student(df, student_name, student_name)
    except KeyError:
        raise HTTPException(status_code=404, detail="Student not found")
    
    # Load specified benchmarks
    comparison_list = []
    if benchmarks:
        for benchmark_id in benchmarks:
            try:
                benchmark_student = create_student(df, benchmark_id, benchmark_id)
                comparison_list.append(benchmark_student)
            except KeyError:
                raise HTTPException(status_code=404, detail=f"Benchmark '{benchmark_id}' not found")
    return StudentResponse(comparison_list=comparison_list,student=student)
     
def main():
    uvicorn.run(app, host="localhost", port=8122)
# ngrok http 8122


if __name__ == "__main__":
    main()