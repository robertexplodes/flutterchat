import 'package:chat/domain/chat.dart';
import 'package:chat/domain/chats.dart';
import 'package:chat/domain/messages.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/widgets/chat_listtile.dart';
import 'package:chat/widgets/constants.dart';
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
    var provider = Provider.of<ChatProvider>(context);
    var chats = provider.loadChats();
    return MaterialApp(
      title: 'Flutter Chat',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chat'),
        ),
        body: Column(
          children: [
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) return const Text("Could not load chats");

                var response = snapshot.data as List<Chat>;
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return chats;
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatListTile(chat: response[index]);
                      },
                      itemCount: response.length,
                    ),
                  ),
                );
              },
              future: chats,
            ),
            const Spacer(),
            TextField(
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Color(0xffece5dd),
              ),
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // added line
                  mainAxisSize: MainAxisSize.min,
                  // added line
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.add,
                        color: accentGrey,
                      ),
                    ),
                  ],
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                filled: true,
                fillColor: darkGrey,
                hintStyle: const TextStyle(
                  color: accentGrey,
                ),
                hintText: 'Neuer Chat',
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
