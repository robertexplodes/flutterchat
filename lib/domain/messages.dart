import 'dart:convert';

import 'package:chat/domain/message.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessageProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  Future<List<Message>> loadMessages(String chatId) async {
    _messages = [];
    var response =
        await http.get(Uri.parse('$baseURL/chats/$chatId/messages.json'));
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    var messages =  data.entries.map((e) => Message(e.key, e.value["content"], e.value["time"])).toList();
    // _messages = messages;
    // _messages.sort((a, b) => a.time.compareTo(b.time));
    // notifyListeners();
    messages.sort((a, b) => a.time.compareTo(b.time));
    return messages;
  }

  void reloadMessages(String chatId) async {
    var newMessages = await loadMessages(chatId);
    for (var message in newMessages) {
      if (!_messages.contains(message)) {
        _messages.add(message);
      }
    }
    notifyListeners();
  }

  void addMessage(Message newMessage) {
    _messages.add(newMessage);
    notifyListeners();
  }
}
