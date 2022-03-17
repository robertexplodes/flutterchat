import 'package:chat/domain/chat.dart';
import 'package:chat/domain/chats.dart';
import 'package:chat/domain/messages.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessageProvider(),
        )
      ],
      child: const FlutterChat(),
    ),
  );
}

class FlutterChat extends StatelessWidget {
  const FlutterChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chats = Provider.of<ChatProvider>(context).loadChats();
    return MaterialApp(
      title: 'Flutter Chat',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chat'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) return const Text("Could not load chats");

            var response = snapshot.data as List<Chat>;
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatPage(chat: response[index]),
                    ));
                  },
                  child: Chip(
                    label: Text(response[index].name),
                    avatar: CircleAvatar(
                      child: Text('${response[index].messageCount}'),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                );
              },
              itemCount: response.length,
            );
          },
          future: chats,
        ),
      ),
    );
  }
}
