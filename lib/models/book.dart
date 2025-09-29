class Book {
  final int id;
  final String title;
  final String author;
  final String? genre;
  final bool available;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    this.genre,
    required this.available,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      genre: map['genre'] as String?,
      available: (map['available'] as bool?) ?? (map['is_available'] as bool? ?? true),
    );
  }
}


