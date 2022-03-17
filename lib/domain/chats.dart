import 'dart:convert';

import 'package:chat/domain/chat.dart';
import 'package:chat/domain/message.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {


  Future<List<Chat>> loadChats() async {
    var response = await http.get(Uri.parse('$baseURL/chats.json'));
    var data = jsonDecode(response.body) as Map<String, dynamic>;

    return data.entries.map((e) {
      var value = e.value as Map<String ,dynamic>;
      var messages = value["messages"] as Map<String, dynamic>;
      var parsedMessages = messages.entries.map((e) => Message(e.key, e.value["content"], e.value["time"])).toList();
      return Chat(e.key, e.value["title"], parsedMessages.length);
    }).toList();
    // return data.entries
    //     .map((e) => Chat(e.key,
    //     e.value["title"],
    //     (e.value["messages"] as Map<String, dynamic>).entries
    //         .map((e) => Message(e.key, e.value)).toList()))
    // .toList();
  }


}
