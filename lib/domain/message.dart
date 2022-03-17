class Message {
  String id;
  String content;

  Message(this.id, this.content);

  @override
  String toString() {
    return 'Message{id: $id, content: $content}';
  }
}