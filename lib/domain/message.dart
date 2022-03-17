class Message {
  String id;
  String content;
  int time;

  Message(this.id, this.content, this.time);

  @override
  String toString() {
    return 'Message{id: $id, content: $content}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}