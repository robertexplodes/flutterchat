import 'package:chat/domain/message.dart';
import 'package:chat/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool messageFromMe;

  MessageWidget(
      {Key? key, required this.message, required this.messageFromMe})
      : super(key: key);

  BorderRadius defaultBorderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(10),
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10));
  BorderRadius messageFromMeRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(10),
      topLeft: Radius.circular(10),
      bottomRight: Radius.circular(10));

  @override
  Widget build(BuildContext context) {
    var parsedDateTime = DateTime.fromMillisecondsSinceEpoch(message.time);
    return Container(
      margin: messageFromMe
          ? const EdgeInsets.fromLTRB(100, 0, 5, 5)
          : const EdgeInsets.fromLTRB(5, 0, 100, 5),
      child: Card(
        elevation: 0,
        color: messageFromMe ? messageGreen : Color.fromRGBO(32, 44, 51, 1),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: messageFromMe ? messageFromMeRadius : defaultBorderRadius
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              messageFromMe
                  ? SizedBox()
                  : SizedBox(
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
                  softWrap: true,
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
