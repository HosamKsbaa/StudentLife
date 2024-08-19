import 'package:flutter/material.dart';
import 'package:nu_ra_stu_jur/pages/CategoryProgressPage.dart';
import 'package:nu_ra_stu_jur/pages/CoursesTree.dart';
import 'package:nu_ra_stu_jur/pages/EligibleCoursesPage.dart';
import 'package:nu_ra_stu_jur/pages/IneligibleCoursesPage.dart';
import 'package:nu_ra_stu_jur/pages/Notifications.dart';
import 'package:nu_ra_stu_jur/pages/competenciesData.dart';
import 'package:nu_ra_stu_jur/pages/drawer.dart';
import 'package:nu_ra_stu_jur/pages/gptchat.dart';
import 'api/models/course_info.dart';
import 'api/models/ineligible_course.dart';
import 'api/models/ra_response.dart';
import 'hosamAddition/HttpReqstats/Loaders/SinglePage.dart';
import 'hosamAddition/HttpReqstats/httpStats.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.studentId});
  final String studentId;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HDMDrawer(), // Optional: Add drawer for navigation
      appBar: AppBar(
        actions: [
          const NotificationICon(),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ApiSinglePage<RAResponse>(
        requestFunction: () => restClient.client.getStudentProgress2StudentStudentIdProgress2Get(studentId: StuId),
        child: (context, RAResponse data) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Center(
                    child: Text(
                      "Course Navigator",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                  child: Text(
                    "Welcome to Course Navigator! This app helps you manage your course selections by showing you eligible and ineligible courses based on your current progress. Track your category credits and plan your academic journey efficiently.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                _buildSectionCard(
                  context,
                  "Eligible Courses",
                  "View the courses you are eligible to take",
                  Icons.check_circle,
                  EligibleCoursesPage(data: data),
                ),
                _buildSectionCard(
                  context,
                  "Ineligible Courses",
                  "Check courses that you are currently not eligible for",
                  Icons.cancel,
                  IneligibleCoursesPage(data: data),
                ),
                _buildSectionCard(
                  context,
                  "Category Progress",
                  "Track your progress across different categories",
                  Icons.assessment,
                  CategoryProgressPage(data: data),
                ),
                _buildSectionCard(
                  context,
                  "Courses Tree",
                  "Plane ahead and see the courses tree",
                  Icons.account_tree,
                  ZoomableImagePage(),
                ),
                _buildSectionCard(
                  context,
                  "Chat with EduBot",
                  "Have a chat with our educational chatbot about everything",
                  Icons.chat,
                  const GptPage(),
                ),
                _buildSectionCard(
                  context,
                  "Show Your Competencies",
                  "Show your competencies",
                  Icons.assessment_outlined,
                  RadarChartSample1(
                    studentId: widget.studentId,
                  ),
                ),
              ],
            ),
          );
        },
        httpRequestsStates: HDMHttpRequestsStates(),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, String title, String subtitle, IconData icon, Widget page) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 16)),
        trailing: Icon(Icons.arrow_forward, size: 30, color: Theme.of(context).colorScheme.primary),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
