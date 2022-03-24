import 'package:chat/domain/message.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var parsedDateTime = DateTime.fromMillisecondsSinceEpoch(message.time);
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 100, 5),
      child: Card(
        elevation: 0,
        color: const Color.fromRGBO(32, 44, 51, 1),
        shadowColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              SizedBox(
                child: Text(
                  message.senderEmail,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                child: Text(
                  message.content,
                  style: TextStyle(
                    color: accentGrey,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat("hh:mm").format(parsedDateTime),
                  style: TextStyle(color: accentGrey, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
