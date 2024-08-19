from pydantic import BaseModel
from typing import List

class SubCategory(BaseModel):
    code: str
    name: str
    amount: float

class Category(BaseModel):
    code: str
    name: str
    amount: float
    sub_categories: List[SubCategory]

class CompetenciesStudent(BaseModel):
    name: str
    categories: List[Category]
class StudentResponse(BaseModel):
    student: CompetenciesStudent
    comparison_list: List[CompetenciesStudent]