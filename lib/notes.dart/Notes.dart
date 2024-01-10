// ignore: file_names
class Notes {
  final int? id;
  final String? title;
  final String? description;

  Notes({this.id, required this.title, required this.description});
  Notes.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'];
  Map<String, Object?> tomap() {
    return {'id': id, 'title': title, 'description': description};
  }
}
