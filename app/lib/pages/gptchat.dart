import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants.dart';
import '../SharedPreferencesHelper.dart';
import '../main.dart'; // Ensure this file contains your chatUrl definition

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class GptPage extends StatefulWidget {
  const GptPage({super.key});

  @override
  State<GptPage> createState() => _GptPageState();
}

class _GptPageState extends State<GptPage> {
  final List<types.Message> _messages = [];
  final _user =  types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
    firstName: profile.name,
    imageUrl: 'https://raw.githubusercontent.com/HosamKsbaa/Public-Media/main/Nulogo.png', // Replace with actual user avatar URL
  );
  final _bot = const types.User(
    id: 'bot',
    firstName: 'Nu Chat Bot',
    imageUrl: 'https://raw.githubusercontent.com/HosamKsbaa/Public-Media/main/Nulogo.png', // Replace with actual bot avatar URL
  );
  final Dio _dio = Dio();

  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesJson = prefs.getString('messages');
    if (messagesJson != null) {
      List<dynamic> messagesList = jsonDecode(messagesJson);
      List<types.Message> loadedMessages = messagesList.map((msg) => types.TextMessage.fromJson(msg)).toList();
      setState(() {
        _messages.addAll(loadedMessages);
      });
    } else {
      _addInitialBotMessage();
    }
  }

  Future<void> _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> messagesList = _messages.map((msg) => msg.toJson()).toList();
    String messagesJson = jsonEncode(messagesList);
    await prefs.setString('messages', messagesJson);
  }

  void _addInitialBotMessage() {
    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: 'Hello! I am Nu Chat Bot. Ask me anything.',
    );
    _addMessage(botMessage);
  }

  Future<void> _askGPT(String question) async {
    String url = SharedPreferencesHelper.chatUrlKey; // Replace with your API URL
    _dio.options.headers['ngrok-skip-browser-warning'] = '1'; // Any value

    setState(() {
      _isTyping = true;
    });

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode({'question': question}),
      );

      if (response.statusCode == 200) {
        _addMessage(types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: randomString(),
          text: response.data['answer'],
        ));
      } else {
        _addMessage(types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: randomString(),
          text: 'Error: ${response.statusMessage}',
        ));
      }
    } catch (e) {
      _addMessage(types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: 'Error: $e',
      ));
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
    _saveMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
    _saveMessages();
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    _askGPT(message.text);
  }

  @override
  Widget build(BuildContext context) =>Chat(
    messages: _messages,
    onSendPressed: _handleSendPressed,
    user: _user,
    typingIndicatorOptions: TypingIndicatorOptions(typingUsers: _isTyping ? [_bot] : []),
    // showUserAvatars: true,
    showUserNames: true,
    // avatarBuilder: (types.User user) => Padding(
    //   padding: const EdgeInsets.all(2.0), // Add padding to the avatar
    //   child: CircleAvatar(
    //     // Set the radius to control the size
    //     backgroundImage: CachedNetworkImageProvider(user.imageUrl ?? '', scale: 10),
    //   ),
    // ),
    timeFormat: DateFormat('h:mm a'), // Customize time format as needed
  );
}
