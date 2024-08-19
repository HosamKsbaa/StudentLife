import 'package:flutter/material.dart';
import '../api/models/ra_response.dart';

class CategoryProgressPage extends StatelessWidget {
  final RAResponse data;

  CategoryProgressPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category Progress")),
      body: ListView.builder(
        itemCount: data.studentData.categoryProgress.length,
        itemBuilder: (context, index) {
          final category = data.studentData.categoryProgress.keys.elementAt(index);
          final progress = data.studentData.categoryProgress[category]!;
          return ListTile(
            title: Text(category),
            subtitle: Text("Earned: ${progress['earned']}, Required: ${progress['required']}"),
          );
        },
      ),
    );
  }
}
