import 'package:chat/domain/chats.dart';
import 'package:chat/widgets/chat_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatSearchService extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final chats = Provider.of<ChatProvider>(context).chats;
    if (query.isEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ChatListTile(chat: chats[index]);
        },
        itemCount: chats.length,
      );
    }
    var filtered = chats
        .where((chat) => chat.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (filtered.isEmpty) {
      return const Center(
        child: Text('No chats found'),
      );
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ChatListTile(chat: filtered[index]);
      },
      itemCount: filtered.length,
    );
  }
}
