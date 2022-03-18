import 'dart:convert';

import 'package:chat/domain/chat.dart';
import 'package:chat/domain/message.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {
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
}
