
 ```mermaid

classDiagram
    class Category {
        +name: str
        +required_credits: int
        +sub_of: Optional[str]
    }

    class Reason {
        +check_type: str
        +pass_or_fail: bool
        +state_description: str
        +reference_to_prerequisite: Optional[Prerequisite]
    }

    class Prerequisite {
        +course: Optional[Course]
        +pass_check(student: Student): Reason
    }

    class CoursePreqest {
        +course: Course
        +pass_check(student: Student): Reason
    }

    class Other {
        +description: str
        +pass_check(student: Student): Reason
    }

    class Course {
        +code: str
        +name: str
        +category: Category
        +prerequisites: List[Union[CoursePreqest, Other]]
        +is_available_this_term: bool
        +typical_year: int
        +term: int
        +for_prereqs: List[Course]
        +serialize_for_json(): dict
    }

    class Student {
        +id: str
        +courses_taken: List[Course]
        +get_current_credit(): int
        +has_passed_course(course: Course): bool
    }

    Prerequisite <|-- CoursePreqest
    Prerequisite <|-- Other
    Course "1" *-- "1" Category : has
    Course "*" *-- "*" Prerequisite : has
    Student "1" -- "*" Course : takes

    class load_categories {
        +load_categories(file_path: str): List[Category]
    }

    class load_courses {
        +load_courses(file_path: str, categories: List[Category]): List[Course]
    }

    class load_students {
        +load_students(file_path: str, courses: List[Course], mapping: dict): List[Student]
    }

    class parse_prerequisites {
        +parse_prerequisites(course_row: dict, courses_dict: dict): List[Prerequisite]
    }

    class get_eligible_courses {
        +get_eligible_courses(student: Student, courses: List[Course]): dict
    }

    class main {
        +main()
    }

    load_categories ..> Category : creates
    load_courses ..> Course : creates
    load_courses ..> parse_prerequisites : uses
    load_students ..> Student : creates
    get_eligible_courses ..> Course : uses
    get_eligible_courses ..> Student : uses
    main ..> load_categories : calls
    main ..> load_courses : calls
    main ..> load_students : calls
    main ..> get_eligible_courses : calls


```
i want you first to load all the catogryes from them data/prerequisites - Categories.csv
here is the head Subject Area,Number of Credits,SubOf

then load all corses from data/prerequisites - Courses (1).csv
here is the head 
no.,Categories,Code,x,Name,y,z,preq corses,preq other,,,,,,,,,,,,,,,,,,,,,,

then  
l load the student from the data/prerequisites - Student.csv , note  the header are StudentID,ENGL001,ENGL002, ,... with the rest of the corses code , note that the codes aren't simmiler , so you will use the maapint  here   data/prerequisites - Maping (1).csv -->