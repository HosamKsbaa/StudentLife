import 'package:flutter/material.dart';
import '../../SharedPreferencesHelper.dart';
import '../../main.dart';

class UpdateUrlsPage extends StatefulWidget {
  const UpdateUrlsPage({Key? key}) : super(key: key);

  @override
  _UpdateUrlsPageState createState() => _UpdateUrlsPageState();
}

class _UpdateUrlsPageState extends State<UpdateUrlsPage> {
  final _baseUrlController = TextEditingController();
  final _chatUrlController = TextEditingController();
  final _stuIdController = TextEditingController();

  final SharedPreferencesHelper _sharedPreferencesHelper = SharedPreferencesHelper();

  @override
  void initState() {
    super.initState();
    _loadUrls();
  }

  Future<void> _loadUrls() async {
    _baseUrlController.text = await _sharedPreferencesHelper.getBaseUrl();
    _chatUrlController.text = await _sharedPreferencesHelper.getChatUrl();
    _stuIdController.text = await _sharedPreferencesHelper.getStuId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update URLs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _baseUrlController,
                decoration: const InputDecoration(labelText: 'Base URL'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _chatUrlController,
                decoration: const InputDecoration(labelText: 'Chat URL'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _stuIdController,
                decoration: const InputDecoration(labelText: 'Student ID'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                List<String> studentIds = [
                  '211001892',
                  '211001926',
                  '211001948',
                  '211001978',
                  '211002041',
                  '211002132',
                  '211002176',
                  '211002194',
                  '212002407',
                  '221001592',
                  '211001978',
                ];

                await _sharedPreferencesHelper.saveBaseUrl(_baseUrlController.text);
                await _sharedPreferencesHelper.saveChatUrl(_chatUrlController.text);

                String stuId = _stuIdController.text;

                if (studentIds.contains(stuId)) {
                  await _sharedPreferencesHelper.saveStuId(stuId);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('URLs updated successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("The $stuId student's competency data isn't ready yet. Please choose another student.")),
                  );
                }
              },
              child: const Text('Update URLs'),
            ),
          ],
        ),
      ),
    );
  }
}
