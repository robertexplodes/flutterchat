import 'dart:convert';

import 'package:chat/domain/chat_search_service.dart';
import 'package:chat/domain/chats.dart';
import 'package:chat/domain/auth_provider.dart';
import 'package:chat/widgets/chat_listtile.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ChatsPage extends StatefulWidget {
  static const String route = '/chats';

  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  var newChatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChatProvider>(context);
    var chats = provider.reloadChats();
    return Scaffold(
      appBar: AppBar(
        title: Text('Chads'),
        // backgroundColor: darkGrey,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ChatSearchService(),
                  );
                },
                icon: Icon(Icons.search),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).popAndPushNamed('/');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        color: whatsappGrey,
        child: Column(
          children: [
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError)
                  return const Text("Could not load chats");

                // var response = snapshot.data as List<Chat>;
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return provider.reloadChats();
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatListTile(chat: provider.chats[index]);
                      },
                      itemCount: provider.chats.length,
                    ),
                  ),
                );
              },
              future: chats,
            ),
            TextField(
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Color(0xffece5dd),
              ),
              controller: newChatController,
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // added line
                  mainAxisSize: MainAxisSize.min,
                  // added line
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: accentGrey,
                        ),
                        onPressed: () {
                          handleNewChat();
                        },
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

  void handleNewChat() {
    var text = newChatController.text;
    newChatController.clear();
    http.post(Uri.parse('$baseURL/chats/.json'),
        body: jsonEncode({
          "title": text,
          "picture":
              "https://i.pinimg.com/474x/3f/de/86/3fde8620893d9a399a8f9214c76cdc9a.jpg",
        }));
  }
}
