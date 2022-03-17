import 'package:chat/domain/message.dart';

class Chat {
  String id;
  String name;
  List<Message> messages;


  Chat(this.id, this.name, this.messages);

  @override
  String toString() {
    return 'Chat{id: $id, name: $name, messages: $messages}';
  }
}