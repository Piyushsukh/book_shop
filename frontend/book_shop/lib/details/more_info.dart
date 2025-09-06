class Subject {
  final int id;
  final String name;
  const Subject({required this.id, required this.name});

  factory Subject.fromJSON(Map<String, dynamic> map) {
    return Subject(id: map['id'] as int, name: map['name'] as String);
  }

  static fromJson(book) {}
}
