import 'package:flutter/material.dart';
import 'package:nu_ra_stu_jur/pages/CategoryProgressPage.dart';
import 'package:nu_ra_stu_jur/pages/CoursesTree.dart';
import 'package:nu_ra_stu_jur/pages/EligibleCoursesPage.dart';
import 'package:nu_ra_stu_jur/pages/IneligibleCoursesPage.dart';
import 'package:nu_ra_stu_jur/pages/Notifications.dart';
import 'package:nu_ra_stu_jur/pages/StudentHistory/inPage.dart';
import 'package:nu_ra_stu_jur/pages/competenciesData.dart';
import 'package:nu_ra_stu_jur/pages/gptchat.dart';
import 'package:nu_ra_stu_jur/pages/profile.dart';
import 'CustomResUI/scafold.dart';
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
    return ApiSinglePage<RAResponse>(
      requestFunction: () => restClient.client.getStudentProgress2StudentStudentIdProgress2Get(studentId: widget.studentId),
      child: (context, RAResponse data) {
        return ResponsiveScaffold(

          navbarItems: [
            NavbarItem(text: 'Home', icon: Icons.home_outlined, widget:ProfilePage()),
            NavbarItem(
              text: 'Overview',
              icon: Icons.school_outlined,
              widget: CoursesOverviewPage(data: data),
            ),
            // NavbarItem(text: 'Eligible Courses', icon: Icons.check_circle_outline, widget: EligibleCoursesPage(data: data)),
            // NavbarItem(text: 'Ineligible Courses', icon: Icons.cancel_outlined, widget: IneligibleCoursesPage(data: data)),
            // NavbarItem(text: 'Category Progress', icon: Icons.assessment_outlined, widget: CategoryProgressPage(data: data)),
            // NavbarItem(text: 'Courses Tree', icon: Icons.account_tree_outlined, widget: ZoomableImagePage()),
            NavbarItem(text: 'EduBot', icon: Icons.chat_outlined, widget: const GptPage()),
            NavbarItem(text: 'Competencies', icon: Icons.assessment_outlined, widget: RadarChartSample1(studentId: widget.studentId)),
          ],
          initialIndex: 0,
        );
      },
      httpRequestsStates: HDMHttpRequestsStates(),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
