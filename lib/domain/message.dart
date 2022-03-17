class Message {
  String id;
  String content;
  int time;

  Message(this.id, this.content, this.time);

  @override
  String toString() {
    return 'Message{id: $id, content: $content}';
  }
}