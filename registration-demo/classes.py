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
