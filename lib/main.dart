import 'dart:convert';

import 'package:chat/domain/chat_search_service.dart';
import 'package:chat/domain/chats.dart';
import 'package:chat/domain/messages.dart';
import 'package:chat/pages/chats_page.dart';
import 'package:chat/widgets/chat_listtile.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
      child: FlutterChat(),
    ),
  );
}

class FlutterChat extends StatelessWidget {
  FlutterChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: darkGrey,
          foregroundColor: accentGrey,
        ),
      ),
      home: ChatsPage(),
    );
  }

}
