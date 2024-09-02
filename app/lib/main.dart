import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nu_ra_stu_jur/api/export.dart';
import 'package:nu_ra_stu_jur/hosamAddition/HttpReqstats/Loaders/SinglePage.dart';
import 'Constants.dart';
import 'CustomResUI/scafold.dart';
import 'SharedPreferencesHelper.dart';
import 'ThemeData.dart';
import 'hosamAddition/HttpReqstats/httpStats.dart';
import 'mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';

late RestClient restClient;
late SharedPreferencesHelper sharedPreferencesHelper;
String StuId = "211001892";
// import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveScaffold(
        drawerItems: [
          DrawerItem(text: 'Item 1', onPressed: () => print('Item 1 tapped')),
          DrawerItem(text: 'Item 2', onPressed: () => print('Item 2 tapped')),
        ],
        navbarItems: [
          NavbarItem(text: 'Home', icon: Icons.home, widget: Text("Home")),
          NavbarItem(text: 'Search', icon: Icons.search, widget: Text("Search")),
        ],
        initialIndex: 0,
      ),
    );
  }
}
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class UpdateUrlsPage extends StatefulWidget {
//   const UpdateUrlsPage({Key? key}) : super(key: key);
//
//   @override
//   _UpdateUrlsPageState createState() => _UpdateUrlsPageState();
// }
//
// class _UpdateUrlsPageState extends State<UpdateUrlsPage> {
//   final _baseUrlController = TextEditingController();
//   final _chatUrlController = TextEditingController();
//   final _stuIdController = TextEditingController();
//
//   final SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUrls();
//   }
//
//   Future<void> _loadUrls() async {
//     _baseUrlController.text = await _sharedPreferencesHelper.getBaseUrl();
//     _chatUrlController.text = await _sharedPreferencesHelper.getChatUrl();
//     _stuIdController.text = await _sharedPreferencesHelper.getStuId();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         title: const Text('Update URLs'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _baseUrlController,
//                 decoration: const InputDecoration(labelText: 'Base URL'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _chatUrlController,
//                 decoration: const InputDecoration(labelText: 'Chat URL'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _stuIdController,
//                 decoration: const InputDecoration(labelText: 'Student ID'),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 List<String> studentIds = [
//                   '211001892',
//                   '211001926',
//                   '211001948',
//                   '211001978',
//                   '211002041',
//                   '211002132',
//                   '211002176',
//                   '211002194',
//                   '212002407',
//                   '221001592',
//                   '211001978',
//                 ];
//
//                 await _sharedPreferencesHelper.saveBaseUrl(_baseUrlController.text);
//                 await _sharedPreferencesHelper.saveChatUrl(_chatUrlController.text);
//
//                 String stuId = _stuIdController.text;
//
//                 if (studentIds.contains(stuId)) {
//                   await _sharedPreferencesHelper.saveStuId(stuId);
//
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('URLs updated successfully')),
//                   );
//
//                   // Navigate to the main page after a successful update
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => MyHomePage(
//                               title: 'Student Life',
//                               studentId: _stuIdController.text,
//                             )),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("The $stuId student's competency data isn't ready yet. Please choose another student.")),
//                   );
//                 }
//               },
//               child: const Text('Update URLs'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   Future<void> _initialize() async {
//     sharedPreferencesHelper = SharedPreferencesHelper();
//     await sharedPreferencesHelper.getBaseUrl();
//     await sharedPreferencesHelper.getChatUrl();
//     await _initRestClient();
//   }
//
//   Future<void> _initRestClient() async {
//     String baseUrl = await sharedPreferencesHelper.getBaseUrl() ?? SharedPreferencesHelper.baseUrlKey;
//     Dio dio = Dio();
//     dio.options.headers['ngrok-skip-browser-warning'] = '1'; // Any value
//     restClient = RestClient(dio, baseUrl: baseUrl);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initialize(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return MaterialApp(
//             title: 'Flutter Demo',
//             theme: lightTheme,
//             debugShowCheckedModeBanner: false,
//             home: Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return OverlaySupport.global(
//             child: MaterialApp(
//               title: 'Flutter Demo',
//               theme: lightTheme,
//               debugShowCheckedModeBanner: false,
//               home: Scaffold(
//                 body: Center(
//                   child: Text('Error: ${snapshot.error}'),
//                 ),
//               ),
//             ),
//           );
//         } else {
//           return MaterialApp(
//             title: 'Flutter Demo',
//             theme: lightTheme,
//             debugShowCheckedModeBanner: false,
//             home: const UpdateUrlsPage(),
//           );
//         }
//       },
//     );
//   }
// }
