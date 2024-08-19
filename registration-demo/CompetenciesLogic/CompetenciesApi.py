from fastapi import FastAPI, HTTPException
import pandas as pd
from typing import List, Dict
from CompetenciesLogic.models import SubCategory, Category, CompetenciesStudent


def load_csv(csv_path: str) -> pd.DataFrame:
    """Load and preprocess the CSV file."""
    df = pd.read_csv(csv_path)
    df.columns = df.columns.str.strip()  # Strip any whitespace from the column names
    df.columns = df.columns.map(str)  # Ensure all columns are treated as strings
    return df


def extract_student_names(df: pd.DataFrame) -> List[str]:
    """Extract student names from the DataFrame."""
    return df.columns[2:]  # Assuming first two columns are 'Category' and 'Sub-Category'


def create_sub_categories(category_code: str, student_data: pd.DataFrame) -> List[SubCategory]:
    """Create a list of SubCategory objects for a given category."""
    sub_categories = [
        SubCategory(
            code=row['Sub-Category'].split(':')[0],
            name=row['Sub-Category'].split(':')[1],
            amount=row['Amount']
        )
        for _, row in student_data.iterrows() if row['Category'] == category_code
    ]
    return sub_categories


def calculate_category_average(student_data: pd.DataFrame, category_code: str) -> float:
    """Calculate the average (sum/count) for a category."""
    sub_category_data = student_data[student_data['Category'] == category_code]['Amount']
    total_amount = sub_category_data.sum()
    count = sub_category_data.count()
    return total_amount / count if count != 0 else 0


def create_categories(df: pd.DataFrame, student_data: pd.DataFrame) -> List[Category]:
    """Create a list of Category objects from the DataFrame."""
    categories = []  # Initialize an empty list to accumulate categories
    for category_code in df['Category'].unique():
        category_average = calculate_category_average(student_data, category_code)
        sub_categories = create_sub_categories(category_code, student_data)
        
        # Create the Category object
        category = Category(
            code=category_code.split(':')[0],
            name=category_code.split(':')[1],
            amount=category_average,
            sub_categories=sub_categories
        )
        
        # Append the category to the list
        categories.append(category)
    
    return categories


def create_student(df: pd.DataFrame, student_name: str, student_id: str) -> CompetenciesStudent:
    """Create a Student object."""
    if student_name not in df.columns:
        raise KeyError(f"'{student_name}' not in DataFrame columns.")

    student_data = df[['Category', 'Sub-Category', student_name]].copy()
    student_data.columns = ['Category', 'Sub-Category', 'Amount']
    categories = create_categories(df, student_data)
    return CompetenciesStudent(id=student_id, name=student_name, categories=categories)


def load_student_data(csv_path: str) -> pd.DataFrame:
    """Load the student data CSV file into a DataFrame."""
    return load_csv(csv_path)


# Load all students into memory
students_data = load_student_data('data/Competencies/CompetenciesDataTempStu.csv')
