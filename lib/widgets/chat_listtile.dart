import 'package:chat/domain/chat.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatListTile extends StatelessWidget {
  final Chat chat;

  const ChatListTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatPage(chat: chat),
        ));
      },
      child: Container(
        height: 70,
        color: darkGrey,
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                showProfilepicture(context);
              },
              child: CircleAvatar(
                backgroundImage: Image.network(
                  chat.imageURL,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/default_user.png");
                  },
                ).image,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                chat.name,
                style: const TextStyle(
                  color: accentGrey,
                ),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: primaryGreen,
                child: Text(
                  '${chat.messageCount}',
                  style: const TextStyle(color: accentGrey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showProfilepicture(BuildContext context) {
    var controller = TextEditingController(text: chat.imageURL);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  chat.imageURL,
                  height: 200,
                ),
              ),
              Expanded(
                child: Material(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      chat.imageURL = controller.text;
                      controller.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
