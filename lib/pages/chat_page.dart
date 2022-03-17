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

class ChatPage extends StatelessWidget {
  final Chat chat;

  ChatPage({Key? key, required this.chat}) : super(key: key);

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.name),
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
              child: FutureBuilder(
                future: Provider.of<MessageProvider>(context, listen: false)
                    .loadMessages(chat.id),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Message>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text(
                      "Could not load chats",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  }

                  if (snapshot.hasData) {
                    print(snapshot.data!);
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return MessageWidget(message: snapshot.data![index]);
                      },
                      itemCount: snapshot.data!.length,
                    );
                  }
                  return SizedBox();
                },
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
                        http
                            .post(
                              Uri.parse(
                                  '$baseURL/chats/${chat.id}/messages.json'),
                              body: jsonEncode({
                                "content": controller.text,
                              }),
                            )
                            .then((value) => print(jsonDecode(value.body)));
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
