import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:nu_ra_stu_jur/pages/profileCard.dart';
import '../api/models/category.dart';
import '../api/models/competencies_student.dart';
import '../api/models/student_response.dart';
import '../hosamAddition/HttpReqstats/Loaders/SinglePage.dart';
import '../hosamAddition/HttpReqstats/httpStats.dart';
import '../main.dart';
import 'gptchat.dart';

class RadarChartSample1 extends StatefulWidget {
  RadarChartSample1({super.key, required this.studentId});
  final String studentId;
  final gridColor = Colors.purple.withOpacity(0.2);
  final titleColor = Colors.black;

  @override
  State<RadarChartSample1> createState() => _RadarChartSample1State();
}

class _RadarChartSample1State extends State<RadarChartSample1> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;
  double scale = 1.0;

  String selectedBenchmark = "Top of Class"; // Default selected benchmark

  final List<String> benchmarks = [
    "Top of Class",
    "Average Scores",
    "Required in Market",
    "Highest Honors",
    "Top 5%",
    "Top 25%",
    "Industry Standard",
  ];

  void _previousBenchmark() {
    final currentIndex = benchmarks.indexOf(selectedBenchmark);
    if (currentIndex > 0) {
      setState(() {
        selectedBenchmark = benchmarks[currentIndex - 1];
      });
    }
  }

  void _nextBenchmark() {
    final currentIndex = benchmarks.indexOf(selectedBenchmark);
    if (currentIndex < benchmarks.length - 1) {
      setState(() {
        selectedBenchmark = benchmarks[currentIndex + 1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        ProfileCard(
          imageUrl: 'assets/2024-07-30_17-37.png', // Update with the correct image path
          name: 'Hosam Ksbaa',
          major: 'Artificial Intelligence',
          faculty: 'Computer Science and information technology',
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left_rounded, color: Colors.blueAccent),
                onPressed: _previousBenchmark, // Navigate to the previous benchmark
              ),
              GestureDetector(
                onTap: () {
                  // When the user clicks on the text, open the dropdown menu.
                  _showDropdown(context);
                },
                child: Text(
                  selectedBenchmark,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right, color: Colors.blueAccent),
                onPressed: _nextBenchmark, // Navigate to the next benchmark
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(Colors.blueAccent, "My Current Chart"),
            _buildLegendItem(Colors.green, selectedBenchmark),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ApiSinglePage<StudentResponse>(
            httpRequestsStates: HDMHttpRequestsStates(),
            requestFunction: () => restClient.client.readStudentStudentStudentNameGet(
              studentName: StuId,
              benchmarks: benchmarks,
            ),
            child: (context, studentDataFuture) {
              if (studentDataFuture == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final categories = studentDataFuture.student.categories;

              return Center(
                child: GestureDetector(
                  onScaleUpdate: (details) {
                    setState(() {
                      scale = details.scale;
                    });
                  },
                  child: Transform.scale(
                    scale: scale,
                    child: AspectRatio(
                      aspectRatio: 1.3,
                      child: RadarChart(
                        RadarChartData(
                          radarShape: RadarShape.polygon, // Use polygonal shape (hexagon)
                          dataSets: showingDataSets(studentDataFuture, selectedBenchmark), // Pass the selected benchmark
                          titlePositionPercentageOffset: 0.15, // Adjust position to make room for numbers
                          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 10), // Small black text
                          getTitle: (index, angle) {
                            final usedAngle = relativeAngleMode ? angle + angleValue : angleValue;
                            String categoryName = categories[index].name;
                            double currentValue = categories[index].amount.toDouble(); // Multiply by 100
                            double benchmarkValue = getBenchmarkValue(studentDataFuture, selectedBenchmark, index);
                            double delta = currentValue - benchmarkValue;

                            return RadarChartTitle(
                              text: '$categoryName\n'
                                  ' ${currentValue.toStringAsFixed(1)} '
                                  'vs : ${benchmarkValue.toStringAsFixed(1)}\n '
                                  'Δ: ${delta.toStringAsFixed(1)}%',
                              angle: 0,
                            );
                          },

                          tickCount: 7, // More ticks for better granularity
                          ticksTextStyle: const TextStyle(color: Colors.black, fontSize: 6), // Small black text for ticks
                          tickBorderData: const BorderSide(color: Colors.grey, width: 1), // Custom dashed border
                          gridBorderData: BorderSide(color: widget.gridColor.withOpacity(0.7), width: .5, style: BorderStyle.solid),
                        ),
                        swapAnimationDuration: const Duration(milliseconds: 400),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showDropdown(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: benchmarks.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedBenchmark = value;
        });
      }
    });
  }

  Widget _buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }

  double getBenchmarkValue(StudentResponse st, String chosenBenchmark, int index) {
    CompetenciesStudent benchmark = st.comparisonList.where((element) => element.name == chosenBenchmark).first;
    return benchmark.categories[index].amount.toDouble();
  }

  List<RadarDataSet> showingDataSets(StudentResponse st, String chosenBenchmark) {
    // Normalize function to scale values from 0 to 1 and multiply by 100

    // Use 100 as the max value to keep values in the range of 0 to 100
    double maxValue = 1;

    // Create RadarDataSet for the main student's data
    RadarDataSet r1 = RadarDataSet(
      dataEntries: st.student.categories
          .map((e) => RadarEntry(
                value: e.amount.toDouble(),
              ))
          .toList(),
      fillColor: Colors.blueAccent.withOpacity(0.4),
      borderColor: Colors.blueAccent,
      entryRadius: 4,
      borderWidth: 3,
    );

    // Find the benchmark data that matches the chosen benchmark
    CompetenciesStudent benchmark = st.comparisonList.where((element) => element.name == chosenBenchmark).first;

    // Create RadarDataSet for the benchmark data
    RadarDataSet r2 = RadarDataSet(
      dataEntries: benchmark.categories.map((e) => RadarEntry(value: e.amount.toDouble())).toList(),
      fillColor: Colors.green.withOpacity(0.3),
      borderColor: Colors.green,
      entryRadius: 3,
      borderWidth: 2,
    );
    // added just to make the scale from 0 to 100
    RadarDataSet r3 = RadarDataSet(
      dataEntries: st.student.categories
          .map((e) => RadarEntry(
                value: 1.4,
              ))
          .toList(),
      fillColor: Colors.transparent,
      borderColor: Colors.transparent,
      entryRadius: 3,
      borderWidth: 2,
    );
    RadarDataSet r4 = RadarDataSet(
      dataEntries: st.student.categories
          .map((e) => RadarEntry(
                value: 0,
              ))
          .toList(),
      fillColor: Colors.transparent,
      borderColor: Colors.transparent,
      entryRadius: 3,
      borderWidth: 2,
    );
    // Return a list containing both datasets
    return [r1, r2, r3, r4];
  }
}

FloatingActionButton FAB(BuildContext context) => FloatingActionButton(
    child: const Icon(Icons.chat),
    onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GptPage()),
        ));
