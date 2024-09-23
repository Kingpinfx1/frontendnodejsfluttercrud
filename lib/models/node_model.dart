class Note {
  String id;
  String? title = "";
  String? content = "";
  DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["_id"],
      title: map["title"],
      content: map["content"],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
