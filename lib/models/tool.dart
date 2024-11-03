class Tool {
  String id;
  String title;
  String description;

  Tool({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }

  factory Tool.fromMap(Map<String, dynamic> map, String id) {
    return Tool(id: id, title: map['title'], description: map['description']);
  }
}
