import 'dart:convert';

import 'package:chat/domain/chat.dart';
import 'package:chat/domain/message.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {

  List<Chat> _chats = [];

  List<Chat> get chats => [..._chats];

  Future<List<Chat>> loadChats() async {
    var response = await http.get(Uri.parse('$baseURL/chats.json'));
    var data = jsonDecode(response.body) as Map<String, dynamic>;

    return data.entries.map((e) {
      var value = e.value as Map<String, dynamic>;

      int messageCount = value.containsKey("messages")
          ? (value["messages"] as Map<String, dynamic>).entries.length
          : 0;
      // var messages = value["messages"] as Map<String, dynamic>;
      var picture = e.value["picture"] as String;
      return Chat(e.key, e.value["title"], messageCount, picture);
    }).toList();
  }

  Future<void> reloadChats() async {
    var oldLength = _chats.length;
    var newChats = await loadChats();
    for (var chat in newChats) {
      if (!_chats.contains(chat)) {
        _chats.add(chat);
      }
    }
    if(oldLength != _chats.length) notifyListeners();
  }
}
