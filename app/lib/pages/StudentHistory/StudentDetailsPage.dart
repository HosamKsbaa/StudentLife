import 'package:flutter/material.dart';
import 'package:nu_ra_stu_jur/hosamAddition/HttpReqstats/Loaders/SinglePage.dart';
import 'package:nu_ra_stu_jur/main.dart';
import '../../api/models/hd_course.dart';
import '../../api/models/hd_student.dart';
import '../../api/models/hd_term.dart';
import '../../api/models/hd_year.dart';
import '../../hosamAddition/HttpReqstats/httpStats.dart';

class StudentDetailPage extends StatelessWidget {
  final int studentId=int.parse(profile.id);

  StudentDetailPage();

  @override
  Widget build(BuildContext context) {
    return ApiSinglePage<HDStudent>(
      requestFunction: () => restClient.client.getStudentStudentStudentIdHistoryGet(studentId: studentId),
      httpRequestsStates: HDMHttpRequestsStates(),
      child: (context, hDStudent) {
        Widget _buildDetailRow(IconData icon, String label, String value) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Icon(icon, size: 18, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(value)),
              ],
            ),
          );
        }

        Widget buildCourseDetails(HDCourse course) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(Icons.book, 'Course ID', course.courseId),
                  _buildDetailRow(Icons.title, 'Course Name', course.courseName),
                  _buildDetailRow(Icons.group, 'Section', course.courseSection.toString()),
                  _buildDetailRow(Icons.credit_card, 'Credit', course.credit.toString()),
                  _buildDetailRow(Icons.grade, 'Final Grade', course.finalGrade),
                  _buildDetailRow(Icons.star, 'GPA', course.gpa.toString()),
                ],
              ),
            ),
          );
        }


        Widget _buildTermDetails(HDTerm term) {
          List<Widget> courseWidgets = [];
          for (var course in term.courses!) {
            courseWidgets.add(buildCourseDetails(course));
          }

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Term: ${term.termName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  _buildDetailRow(Icons.star_half, 'Term GPA', term.termGpa.toStringAsFixed(2)),
                  _buildDetailRow(Icons.credit_card, 'Total Credits', term.totalCredits.toString()),
                  ...courseWidgets,
                ],
              ),
            ),
          );
        }

        Widget _buildYearDetails(HDYear year) {
          List<Widget> termWidgets = [];
          for (var term in year.terms!) {
            termWidgets.add(_buildTermDetails(term));
          }

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.orange.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Year: ${year.year}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
                  _buildDetailRow(Icons.grade, 'Year GPA', year.yearGpa.toStringAsFixed(2)),
                  _buildDetailRow(Icons.credit_card, 'Total Credits', year.totalCredits.toString()),
                  ...termWidgets,
                ],
              ),
            ),
          );
        }

        Widget _buildAcademicDetails() {
          List<Widget> yearsWidgets = [];
          for (var year in hDStudent.years!) {
            yearsWidgets.add(_buildYearDetails(year));
          }
          return Column(children: yearsWidgets);
        }

        Widget _buildStudentSummary() {
          return Card(
            color: Colors.yellow.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(Icons.person, 'Student ID', hDStudent.peopleId.toString()),
                  _buildDetailRow(Icons.school, 'Program', hDStudent.program),
                  _buildDetailRow(Icons.account_balance, 'Degree', hDStudent.degree),
                  _buildDetailRow(Icons.book, 'Curriculum', hDStudent.curriculum),
                  _buildDetailRow(Icons.location_city, 'College', hDStudent.college),
                  _buildDetailRow(Icons.business, 'Department', hDStudent.department),
                  _buildDetailRow(Icons.layers, 'Level', hDStudent.level.toString()),
                  _buildDetailRow(Icons.star, 'Total GPA', hDStudent.totalGpa.toStringAsFixed(2)),
                  _buildDetailRow(Icons.credit_card, 'Total Credits', hDStudent.totalCredits.toString()),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Student Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildStudentSummary(),
                SizedBox(height: 20),
                _buildAcademicDetails(),
              ],
            ),
          ),
        );
      },
    );
  }
}
