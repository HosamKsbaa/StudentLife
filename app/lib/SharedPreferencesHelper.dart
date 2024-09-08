import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Base URL and Chat URL keys
  static String baseUrlKey = " https://c946-84-36-10-2.ngrok-free.app";
  // static String baseUrlKey = "http://localhost:8122";

  static String chatUrlKey = "http://10.2.132.224:8000/ask2";
// asd
  // StuId key
  static String stuIdKey = "211001892";

  Future<void> saveBaseUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseUrl', url);
    SharedPreferencesHelper.baseUrlKey = url;
  }

  Future<void> saveChatUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('chatUrl', url);
    SharedPreferencesHelper.chatUrlKey = url;
  }

  Future<void> saveStuId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('stuId', id);
    SharedPreferencesHelper.stuIdKey = id;
  }

  Future<String> getBaseUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('baseUrl');
    if (url == null) {
      url = SharedPreferencesHelper.baseUrlKey;
    } else {
      SharedPreferencesHelper.baseUrlKey = url;
    }
    return url;
  }

  Future<String> getChatUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('chatUrl');
    if (url == null) {
      url = SharedPreferencesHelper.chatUrlKey;
    } else {
      SharedPreferencesHelper.chatUrlKey = url;
    }
    return url;
  }

  Future<String> getStuId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('stuId');
    if (id == null) {
      id = SharedPreferencesHelper.stuIdKey;
    } else {
      SharedPreferencesHelper.stuIdKey = id;
    }
    return id;
  }
}
