class Announcement {
  int id;
  String content;
  String title;
  String createdAt;

  Announcement({
    required this.id,
    required this.content,
    required this.title,
    required this.createdAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json["id"],
        content: json["content"],
        title: json["title"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "title": title,
        "created_at": createdAt,
      };
}
