import 'dart:async';
import 'dart:convert';

import 'package:chat/domain/message.dart';
import 'package:chat/domain/messages.dart';
import 'package:chat/widgets/constants.dart';
import 'package:chat/widgets/input_field.dart';
import 'package:chat/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../domain/chat.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MessageProvider>(context);
    Timer.periodic(
        Duration(seconds: 3),
        (Timer t) => Provider.of<MessageProvider>(context, listen: false)
            .loadMessages(widget.chat.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.name),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset("assets/background.png").image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return MessageWidget(message: provider.messages[index]);
                },
                itemCount: provider.messages.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InputField(
                      controller: controller,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: messageGreen,
                    radius: 25,
                    child: IconButton(
                      onPressed: () {
                        var content = controller.text;
                        var timeStamp = DateTime.now().millisecondsSinceEpoch;
                        controller.clear();
                        http
                            .post(
                          Uri.parse(
                              '$baseURL/chats/${widget.chat.id}/messages.json'),
                          body: jsonEncode(
                              {"content": content, "time": timeStamp}),
                        )
                            .then((value) {
                          var response = jsonDecode(value.body);
                          Provider.of<MessageProvider>(context, listen: false)
                              .addMessage(Message(
                                  response["name"], content, timeStamp));
                        }).catchError((error) {});
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
