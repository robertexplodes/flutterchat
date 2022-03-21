import 'package:chat/domain/message.dart';

class Chat {
  String id;
  String name;
  int messageCount;
  String imageURL;


  Chat(this.id, this.name, this.messageCount, this.imageURL);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chat && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}