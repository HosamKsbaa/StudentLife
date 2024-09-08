// import 'dart:io';
//
// import 'package:clipboard/clipboard.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_1/Util/ApiUtils/Widgets/FutWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Util/ApiUtils/Widgets/FutWidget.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_share/flutter_share.dart';
// import 'package:http/http.dart' as http;
// import 'package:device_info/device_info.dart';
// import '../../PreBuiltOptions/FormsWidget/Modles/Model.dart';
// import '../../PreBuiltOptions/FormsWidget/formWidget.dart';
// import '../ApiUtils/Api.dart';
// import '../Chat/AddUser.dart';
// import '../Commen/Notallowed.dart';
// import 'FireabaseAuth.dart';
//
// class UserCheckResponse {
//   final bool exists;
//   final bool hasAllInfo;
//   final String? userId; // Nullable type for optional field
//   final Department? department; // New field for Department
//
//   UserCheckResponse({
//     required this.exists,
//     required this.hasAllInfo,
//     this.userId,
//     this.department, // Initialize the new field
//   });
//
//   // Factory constructor for creating an instance from a JSON map
//   factory UserCheckResponse.fromJson(Map<String, dynamic> json) {
//     return UserCheckResponse(
//       exists: json['exists'],
//       hasAllInfo: json['has_all_info'],
//       userId: json['user_id'],
//       department: json['missing_info'] != null
//           ? Department.fromJson(json['missing_info'])
//           : null,
//     );
//   }
//
//   // Method for converting the instance to a JSON map
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {
//       'exists': exists,
//       'has_all_info': hasAllInfo,
//       'user_id': userId,
//     };
//
//     if (department != null) {
//       data['department'] = department!.toJson();
//     }
//
//     return data;
//   }
// }
//
// class AfterLoginPage extends StatelessWidget {
//   const AfterLoginPage({Key? key}) : super(key: key);
//
//   Future<Map<String, dynamic>> _prepareRequestBody() async {
//     // Get FCM Token
//     String? fcmToken = await FirebaseMessaging.instance.getToken();
//
//     // Get IP Address
//     var response = await http.get(Uri.parse('https://api.ipify.org'));
//     String ipAddress = response.body;
//     String phoneType = "Unknown";
//
//     // Get Device Info
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       phoneType = "${androidInfo.model} (${androidInfo.brand})";
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       phoneType = "${iosInfo.model} (${iosInfo.utsname.machine})";
//     } // Adjust this according to your need
//
//     return {
//       "phone_type": phoneType,
//       "ip_address": ipAddress,
//       "fcm_token": fcmToken ?? "unknown"
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: _prepareRequestBody(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return FutureWidget<UserCheckResponse>(
//             endpoint: "/check-user",
//             type: RequestType.post,
//             requestBody: snapshot.data!,
//             builder: (UserCheckResponse response) {
//               // You can use the response data to determine what to display
//
//               if (response.exists) {
//                 // Navigate to a form page to update user info
//                 // For now, just displaying a text widget
//                 if (!response.hasAllInfo) {
//                   return UserDataEntry(department: response.department!);
//                 } else {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     GlobalNavigator.navigateToAppropriatePage(false);
//                   });
//                   // User has all info, show the next screen or info
//                   return Container();
//                 }
//               }
//               return EmailDisplayPage(
//
//                 message: 'Contact Your admin to add you to the app your Email',
//               );
//             },
//             parser: (json) => UserCheckResponse.fromJson(json),
//           );
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
//
// class UserDataEntry extends StatelessWidget {
//   Department department;
//   UserDataEntry({super.key, required this.department});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Update Information page ")),
//       body: HFormWidget(
//         onSuccess: (a) {
//           Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => UpdateChatInformation()),
//                 (Route<dynamic> route) => false,  // This predicate ensures all routes are removed
//           );
//         },
//         department: department,
//         additinalData: const {"Type": "UserUpdateInfo"},
//       ),
//     );
//   }
// }
//
//
// class EmailDisplayPage extends StatefulWidget {
//   late final String email;
//   final String message;
//
//    EmailDisplayPage({Key? key, required this.message}) : super(key: key);
//
//   @override
//   State<EmailDisplayPage> createState() => _EmailDisplayPageState();
// }
//
// class _EmailDisplayPageState extends State<EmailDisplayPage> {
//
//   Future<void> copyEmail() async {
//     await FlutterClipboard.copy(widget.email);
//     // Show a snackbar or toast to inform the user that the email has been copied
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email copied to clipboard')));
//   }
//
//   Future<void> shareEmail() async {
//     await FlutterShare.share(
//         title: 'Share Email',
//         text: widget.email,
//         chooserTitle: 'Share Email Via'
//     );
//   }
//  @override
//   String? initState() {
//    User? user = FirebaseAuth.instance.currentUser;
//    widget.email= user!.email!; // This will be null if no user is signed in
//    //    super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Email Details')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(widget.message, style: Theme.of(context).textTheme.headline6),
//               const SizedBox(height: 20),
//               SelectableText(widget.email, style: Theme.of(context).textTheme.subtitle1),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: copyEmail,
//                   child: const Text('Copy Email'),
//                 ),
//               ),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: shareEmail,
//                   child: const Text('Share Email'),
//                 ),
//               ),const Center(
//                 child: ElevatedButton(
//                   onPressed: GlobalNavigator.signOut,
//                   child: Text('reload'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
