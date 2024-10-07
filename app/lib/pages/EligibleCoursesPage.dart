import 'package:flutter/material.dart';
import 'package:nu_ra_stu_jur/pages/sucess.dart';
import 'package:photo_view/photo_view.dart';
import '../api/models/ra_response.dart';
import '../api/models/course_info.dart';
import 'HelperWidgets.dart';
import 'StudentHistory/StudentDetailsPage.dart';
import 'competenciesData.dart';

class EligibleCoursesPage extends StatefulWidget {
  final RAResponse data;

  EligibleCoursesPage({required this.data});

  @override
  _EligibleCoursesPageState createState() => _EligibleCoursesPageState();
}

class _EligibleCoursesPageState extends State<EligibleCoursesPage> {
  int _selectedCredits = 0;
  final Set<String> _selectedCourses = {};
  final Map<String, int> _categorySelectedCredits = {};

  void _toggleCourseSelection(int credits, String courseCode, String category) {
    setState(() {
      if (_selectedCourses.contains(courseCode)) {
        _selectedCourses.remove(courseCode);
        _selectedCredits -= credits;
        _categorySelectedCredits[category] = (_categorySelectedCredits[category] ?? 0) - credits;
      } else {
        if (_selectedCredits + credits <= 12) {
          _selectedCourses.add(courseCode);
          _selectedCredits += credits;
          _categorySelectedCredits[category] = (_categorySelectedCredits[category] ?? 0) + credits;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Cannot select more than 12 credits."),
            ),
          );
        }
      }
    });
  }

  Color _getGradeColor(double grade) {
    if (grade >= 3.7) {
      return Colors.green;
    } else if (grade >= 3.2) {
      return Colors.lightGreen;
    } else if (grade >= 3) {
      return Colors.grey;
    } else if (grade >= 2) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getGradeNote(double grade) {
    if (grade >= 3.7) {
      return "Excellent";
    } else if (grade >= 3.2) {
      return "Very Good";
    } else if (grade >= 3) {
      return "Good";
    } else if (grade >= 2) {
      return "Fair";
    } else {
      return "Poor";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FAB(context),
      appBar: AppBar(title: Text("Eligible Courses")),
      body: ListView.builder(
        itemCount: widget.data.studentData.eligibleCourses.length,
        itemBuilder: (context, index) {
          final category = widget.data.studentData.eligibleCourses.keys.elementAt(index);
          final courses = widget.data.studentData.eligibleCourses[category]!;
          final progress = widget.data.studentData.categoryProgress[category]!;
          final selectedCategoryCredits = _categorySelectedCredits[category] ?? 0;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                "$category: ${progress['earned']! + selectedCategoryCredits} / ${progress['required']} credits",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: courses.map((course) {
                final double expectedGrade = (course.expectedGrade ?? 0).toDouble(); // Ensure it's a double
                final Color gradeColor = _getGradeColor(expectedGrade);
                double fontsize = 12;
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                    child: ListTile(
                      title: Text(course.name ?? 'No name available', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.code, size: fontsize),
                              SizedBox(width: 4),
                              Text("Course Code: ${course.code}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.credit_card, size: fontsize),
                              SizedBox(width: 4),
                              Text("Credits: ${course.credits}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: fontsize),
                              SizedBox(width: 4),
                              Text("Year: ${course.typicalYear}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.share_arrival_time_outlined, size: fontsize),
                              SizedBox(width: 4),
                              Text("Term: ${course.term}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.grade, size: fontsize),
                              SizedBox(width: 4),
                              Text("Expected Grade: "),
                              Text(
                                "${expectedGrade.toStringAsFixed(2)} (${_getGradeNote(expectedGrade)})",
                                style: TextStyle(color: gradeColor, fontSize: fontsize),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(
                        _selectedCourses.contains(course.code) ? Icons.check_circle : Icons.add_circle_outline,
                        color: _selectedCourses.contains(course.code) ? Colors.green : null,
                        size: 25,
                      ),
                      onTap: () {
                        _toggleCourseSelection(course.credits, course.code, category);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              if (_selectedCredits == 12) {
                final selectedCourses = widget.data.studentData.eligibleCourses.values.expand((element) => element).where((element) => _selectedCourses.contains(element.code)).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please select exactly 12 credits."),
                  ),
                );
              }
            },
            child: Card(
              color: _selectedCredits == 12 ? Colors.green : Colors.deepOrangeAccent,
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "Register with Credits: $_selectedCredits / 12",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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



class ZoomableImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses Tree'),
      ),
      floatingActionButton: FAB(context),
      body: Center(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.white),
          imageProvider: AssetImage('assets/tree.jpg'),
        ),
      ),
    );
  }
}



class StudentInputPage extends StatefulWidget {
  @override
  _StudentInputPageState createState() => _StudentInputPageState();
}

class _StudentInputPageState extends State<StudentInputPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Student ID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Student ID',

                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentDetailPage(
                      ),
                    ),
                  );
                }
              },
              child: Text('Go to Details'),
            ),
          ],
        ),
      ),
    );
  }
}



class CoursesOverviewPage extends StatelessWidget {
  final RAResponse data;

  CoursesOverviewPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCourseButton(
            context,
            "Eligible Courses",
            "View the courses you are eligible to take",
            Icons.check_circle_outline,
            EligibleCoursesPage(data: data),
          ),
          _buildCourseButton(
            context,
            "Ineligible Courses",
            "Check courses that you are currently not eligible for",
            Icons.cancel_outlined,
            IneligibleCoursesPage(data: data),
          ),
          _buildCourseButton(
            context,
            "Courses Tree",
            "Plan ahead and see the courses tree",
            Icons.account_tree_outlined,
            ZoomableImagePage(),
          ),
          _buildCourseButton(
            context,
            "History",
            "View the courses you have taken",
            Icons.history_outlined,
              StudentDetailPage(),          ),
        ],
      ),
    );
  }

  Widget _buildCourseButton(BuildContext context, String title, String subtitle, IconData icon, Widget page) {
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

