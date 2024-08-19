import 'package:flutter/material.dart';
import '../api/models/ra_response.dart';
import 'HelperWidgets.dart';
import 'competenciesData.dart';

class IneligibleCoursesPage extends StatelessWidget {
  final RAResponse data;

  IneligibleCoursesPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ineligible Courses")),
      floatingActionButton: FAB(context),
      body: ListView.builder(
        itemCount: data.studentData.ineligibleCourses.length,
        itemBuilder: (context, index) {
          final category = data.studentData.ineligibleCourses.keys.elementAt(index);
          final courses = data.studentData.ineligibleCourses[category]!;
          return IneligibleCourseCategory(category: category, courses: courses);
        },
      ),
    );
  }
}
