import 'dart:convert';

import 'package:chat/domain/message.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessageProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  Future<List<Message>> loadMessages(String chatId) async {
    // _messages = [];
    var response =
        await http.get(Uri.parse('$baseURL/chats/$chatId/messages.json'));
    if (response.body == 'null') return [];
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    var messages = data.entries
        .map((e) => Message(e.key, e.value["content"], e.value["time"], e.value["sender"]))
        .toList();
    messages.sort((a, b) => a.time.compareTo(b.time));
    return messages;
  }

  Future<void> reloadMessages(String chatId) async {
    var oldLength = _messages.length;
    var newMessages = await loadMessages(chatId);
    _messages.addAll(newMessages);
    _messages = _messages.toSet().toList();
    if(oldLength != _messages.length) notifyListeners();
  }

  void clearMessages() {
    _messages = [];
  }

  void addMessage(Message newMessage) {
    _messages.add(newMessage);
    notifyListeners();
  }
}
