import 'dart:async';
import 'dart:convert';

import 'package:chat/domain/chats.dart';
import 'package:chat/domain/login_provider.dart';
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

  const ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var controller = TextEditingController();

  bool _shouldRefresh = true;

  ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<MessageProvider>(context, listen: false)
      .reloadMessages(widget.chat.id);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MessageProvider>(context);

    Timer.periodic(
        const Duration(seconds: 3),
            (timer) {
          if(!_shouldRefresh) {
            timer.cancel();
            return;
          }
          Provider.of<MessageProvider>(context, listen: false)
              .reloadMessages(widget.chat.id);
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(32, 44, 51, 1),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: Image.network(widget.chat.imageURL).image,
            ),
            const SizedBox(width: 10),
            Text(widget.chat.name),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _shouldRefresh = false;
            Provider.of<MessageProvider>(context, listen: false)
                .clearMessages();
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset("assets/background.png").image,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
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
                        if (content.isEmpty) return;
                        controller.clear();

                        sendMessage(content, context);
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

  void sendMessage(String content, BuildContext context) {
    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    var user = Provider.of<LoginProvider>(context, listen: false).user;
    http
        .post(
      Uri.parse('$baseURL/chats/${widget.chat.id}/messages.json'),
      body: jsonEncode({"content": content, "time": timeStamp, "sender": user!.email}),
    )
        .then((value) {
      var response = jsonDecode(value.body);
      var user = Provider.of<LoginProvider>(context).user;
      Provider.of<MessageProvider>(context, listen: false)
          .addMessage(Message(response["name"], content, timeStamp, user?.email));
    }).catchError((error) {});
  }
}
