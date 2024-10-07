# Define classes for Profile, Skill, Experience, and Certificate
from typing import List

from pydantic import BaseModel


class Skill(BaseModel):
    name: str
    score: int


class Experience(BaseModel):
    title: str
    company: str
    location: str
    period: str


class Certificate(BaseModel):
    title: str
    issuer: str
    date: str
    credentialId: str


class XProfile(BaseModel):
    id: str
    email: str
    name: str
    password: str
    major: str = "Artificial intelligence"
    department: str = "Computer Science and information technology"
    currentSemester: int
    enrolledCourses: int
    completedCourses: int
    coursesInProgress: int
    skills: List[Skill]
    experiences: List[Experience]
    certificates: List[Certificate]


# Manually written data
Xstudents_data = [
    XProfile(
        id="211001892",
        email="A.sameh2192@nu.edu.eg",
        name="Arwa Sameh ",
        password="xp982a26",
        currentSemester=4,
        enrolledCourses=5,
        completedCourses=20,
        coursesInProgress=5,
        skills=[
            Skill(name="Python", score=90),
            Skill(name="Data Structures", score=85),
            Skill(name="Algorithms", score=88)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co", location="Alexandria", period="4 months")],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification", issuer="Udemy", date="2023-03-25", credentialId="PQR23456")]
    ),
    XProfile(
        id="211001926",
        email="M.Ahmed2126@nu.edu.eg",
        name="Mohamed Ahmed ",
        password="5o71fv5t",
        currentSemester=6,
        enrolledCourses=7,
        completedCourses=35,
        coursesInProgress=7,
        skills=[
            Skill(name="Java", score=85),
            Skill(name="Database Systems", score=82),
            Skill(name="Software Engineering", score=88)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co", location="Alexandria", period="4 months")],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification", issuer="Udemy", date="2023-03-25", credentialId="PQR23456")]
    ),
    XProfile(
        id="211001948",
        email="Y.Mohammed2148@nu.edu.eg",
        name="Yousef Mohammed ",
        password="29i65wji",
        currentSemester=3,
        enrolledCourses=6,
        completedCourses=15,
        coursesInProgress=6,
        skills=[
            Skill(name="C++", score=88),
            Skill(name="Operating Systems", score=86),
            Skill(name="Computer Networks", score=80)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co", location="Alexandria", period="4 months")],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification", issuer="Udemy", date="2023-03-25", credentialId="PQR23456")]
    ),
    XProfile(
        id="211001978",
        email="a.khaled2178@nu.edu.eg",
        name="Abdallah Khaled ",
        password="23p0dsqh",
        currentSemester=7,
        enrolledCourses=8,
        completedCourses=40,
        coursesInProgress=8,
        skills=[
            Skill(name="Machine Learning", score=92),
            Skill(name="Artificial Intelligence", score=95),
            Skill(name="Deep Learning", score=90)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co", location="Alexandria", period="4 months")],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification", issuer="Udemy", date="2023-03-25", credentialId="PQR23456")]
    ),
    XProfile(
        id="211002132",
        email="A.Mohammed2132@nu.edu.eg",
        name="Abdullah Mohammed ",
        password="4p71730v",
        currentSemester=5,
        enrolledCourses=6,
        completedCourses=30,
        coursesInProgress=6,
        skills=[
            Skill(name="Data Science", score=89),
            Skill(name="Machine Learning", score=92),
            Skill(name="Big Data", score=87)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co", location="Alexandria", period="4 months")],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification", issuer="Udemy", date="2023-03-25", credentialId="PQR23456")]
    ),
    XProfile(
        id="211002176",
        email="s.ahmed2176@nu.edu.eg",
        name="Sara Ahmed ",
        password="cs5w12z9",
        currentSemester=4,
        enrolledCourses=5,
        completedCourses=25,
        coursesInProgress=5,
        skills=[
            Skill(name="Cybersecurity", score=91),
            Skill(name="Ethical Hacking", score=89),
            Skill(name="Network Security", score=88)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co", location="Alexandria", period="4 months")],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification", issuer="Udemy", date="2023-03-25", credentialId="PQR23456")]
    ),
    XProfile(
        id="211002194",
        email="m.moamen2194@nu.edu.eg",
        name="Mohamed Moamen ",
        password="g8jy8zl8",
        currentSemester=6,
        enrolledCourses=7,
        completedCourses=35,
        coursesInProgress=7,
        skills=[
            Skill(name="Web Development", score=87),
            Skill(name="ReactJS", score=85),
            Skill(name="NodeJS", score=83)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co", location="Alexandria", period="4 months")],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification", issuer="Udemy", date="2023-03-25", credentialId="PQR23456")]
    ),
    XProfile(
        id="212002407",
        email="o.mohamed2107@nu.edu.eg",
        name="Omar Mohamed ",
        password="b769goai",
        currentSemester=5,
        enrolledCourses=6,
        completedCourses=30,
        coursesInProgress=6,
        skills=[
            Skill(name="Cloud Computing", score=90),
            Skill(name="AWS", score=88),
            Skill(name="Azure", score=85)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co", location="Alexandria", period="4 months")],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification", issuer="Udemy", date="2023-03-25", credentialId="PQR23456")]
    ),
    XProfile(
        id="221001592",
        email="f.mohamed2292@nu.edu.eg",
        name="Farah Mohamed ",
        password="l62c0t15",
        currentSemester=4,
        enrolledCourses=5,
        completedCourses=25,
        coursesInProgress=5,
        skills=[
            Skill(name="AI", score=92),
            Skill(name="Deep Learning", score=90),
            Skill(name="Natural Language Processing", score=87)
        ],
        experiences=[
            Experience(title="AI Research Assistant",
                       company="AI Research Lab", location="Cairo", period="5 months"),
            Experience(title="Web Developer", company="Web Solutions",
                       location="Cairo", period="6 months"),
            Experience(title="Cloud Intern", company="Cloud Co",
                       location="Alexandria", period="4 months")

        ],
        certificates=[
            Certificate(title="AI Certification", issuer="Google",
                        date="2023-07-01", credentialId="VWX45678"),
            Certificate(title="Cloud Computing Certification",
                        issuer="AWS", date="2023-06-01", credentialId="STU98765"),
            Certificate(title="Web Development Certification",
                        issuer="Udemy", date="2023-03-25", credentialId="PQR23456")


        ]
    ),
]
