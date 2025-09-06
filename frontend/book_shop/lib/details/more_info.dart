class Subject {
  final int id;
  final String name;
  const Subject({required this.id, required this.name});

  factory Subject.fromJSON(Map<String, dynamic> map) {
    return Subject(id: map['id'] as int, name: map['name'] as String);
  }
}

class Author {
  final int id;
  final String name;
  const Author({required this.id, required this.name});

  factory Author.fromJSON(Map<String, dynamic> map) {
    return Author(id: map['id'] as int, name: map['name'] as String);
  }
}

class Publisher {
  final int id;
  final String name;
  const Publisher({required this.id, required this.name});

  factory Publisher.fromJSON(Map<String, dynamic> map) {
    return Publisher(id: map['id'] as int, name: map['name'] as String);
  }
}
