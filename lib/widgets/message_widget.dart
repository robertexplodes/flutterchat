import 'package:chat/domain/message.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message.content,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      color: Colors.blueAccent,
      padding: EdgeInsets.all(16),
    );
  }
}
