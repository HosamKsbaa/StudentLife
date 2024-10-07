// import 'package:flutter/material.dart';
//
// import 'StudentDetailsPage.dart';
//
//
//
// class StudentInputPage extends StatefulWidget {
//   @override
//   _StudentInputPageState createState() => _StudentInputPageState();
// }
//
// class _StudentInputPageState extends State<StudentInputPage> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter Student ID'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 labelText: 'Student ID',
//
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (_controller.text.isNotEmpty) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => StudentDetailPage(
//                         studentId: int.parse(_controller.text),
//                       ),
//                     ),
//                   );
//                 }
//               },
//               child: Text('Go to Details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
