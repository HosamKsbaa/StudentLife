import 'package:flutter/material.dart';
import '../api/models/course_info.dart';
import 'package:flutter/material.dart';
import '../api/models/ineligible_course.dart';

class IneligibleCourseCategory extends StatelessWidget {
  final String category;
  final List<IneligibleCourse> courses;

  IneligibleCourseCategory({required this.category, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
        children: courses
            .map((course) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        course.course.name ?? 'No name available',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: course.reasons.map((reason) => Text(reason)).toList(),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
