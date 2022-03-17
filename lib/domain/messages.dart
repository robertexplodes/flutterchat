import 'dart:convert';

import 'package:chat/domain/message.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessageProvider with ChangeNotifier {
  Future<List<Message>> loadMessages(String chatId) async {
    var response =
        await http.get(Uri.parse('$baseURL/chats/$chatId/messages.json'));
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    return data.entries.map((e) => Message(e.key, e.value["content"])).toList();
  }
}
