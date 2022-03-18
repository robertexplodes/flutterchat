import 'package:chat/domain/message.dart';

class Chat {
  String id;
  String name;
  int messageCount;
  String imageURL;


  Chat(this.id, this.name, this.messageCount, this.imageURL);
}