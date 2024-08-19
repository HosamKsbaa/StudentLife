# Project Overview

This project involves creating an API for managing and tracking student course progress and prerequisites using FastAPI. The project allows for loading course data, student data, and category data from CSV files, and provides endpoints for fetching student progress in Markdown and JSON formats.

## Dependencies

- Python
- FastAPI
- Pydantic
- Uvicorn
- Requests

## Project Structure

### Main Components

1. **Models**:
- `Category`: Represents a course category with required credits and optional subcategories.
- `Reason`: Represents the result of a prerequisite check, including pass/fail status and a description.
- `Prerequisite`: Represents a course prerequisite and includes a method for checking if a student has passed it.
- `CoursePreqest`: Extends `Prerequisite` for course-specific prerequisites.
- `Other`: Represents other types of prerequisites.
- `Course`: Represents a course with attributes like code, name, category, prerequisites, availability, credits, etc.
- `Student`: Represents a student with an ID and a list of taken courses.
- `DependencyTree`: Represents the dependency structure of courses.
- `CourseInfo`: Provides detailed information about a course including predicted grade and dependency tree.
- `IneligibleCourse`: Represents a course that a student is not eligible to take and the reasons.
- `StudentData`: Aggregates eligible and ineligible courses, and category progress for a student.
- `RAResponse`: Combines student data and graph output for API responses.

2. **FastAPI Application**:
- Configured with CORS middleware to allow requests from any origin.
- Endpoints to fetch student progress in Markdown and JSON formats.

3. **Data Loading Functions**:
- `load_categories`: Loads category data from a CSV file.
- `parse_prerequisites`: Parses course prerequisites from CSV data.
- `load_courses`: Loads course data and establishes prerequisite relationships.
- `load_course_mapping`: Loads a mapping between student course codes and course codes.
- `load_students`: Loads student data and their taken courses.

4. **Helper Functions**:
- `calculate_category_credits`: Calculates the credits earned by a student in each category.
- `build_dependency_tree`: Builds a dependency tree for a course.
- `get_eligible_courses`: Determines the courses a student is eligible or ineligible to take.
- `create_dependency_graph`: Creates a dependency graph in Mermaid format.
- `calculate_category_progress`: Calculates the progress of a student in each category.
- `fetch_predicted_grades`: Mock function to fetch predicted grades for courses.
- `write_course_info_to_md_file`: Writes student progress information to a Markdown file.
- `process_student_data`: Processes student data to determine eligible and ineligible courses and creates dependency graphs.

### FastAPI Endpoints

- `GET /student/{student_id}/progress`: Fetches student progress and returns it in Markdown format.
- `GET /student/{student_id}/progress2`: Fetches student progress and returns it in JSON format with detailed course and dependency information.

### Main Function

- `main()`: Starts the FastAPI server on localhost port 8122 using Uvicorn.

## Running the Project

1. Install the required dependencies:
```bash
pip install fastapi uvicorn pydantic requests



