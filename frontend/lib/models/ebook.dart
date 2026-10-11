class Ebook {
  final int? id;
  final String title;
  final String author;
  final String? description;
  final String filePath;
  final int fileSize;
  final DateTime uploadedAt;

  Ebook({
    this.id,
    required this.title,
    required this.author,
    this.description,
    required this.filePath,
    required this.fileSize,
    required this.uploadedAt,
  });

  factory Ebook.fromJson(Map<String, dynamic> json) {
    return Ebook(
      id: json['id'] as int?,
      title: json['title'] as String? ?? 'Unknown',
      author: json['author'] as String? ?? 'Unknown',
      description: json['description'] as String?,
      filePath: json['file_path'] as String? ?? '',
      fileSize: json['file_size'] as int? ?? 0,
      uploadedAt: json['uploaded_at'] != null
          ? DateTime.parse(json['uploaded_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'file_path': filePath,
      'file_size': fileSize,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }

  Ebook copyWith({
    int? id,
    String? title,
    String? author,
    String? description,
    String? filePath,
    int? fileSize,
    DateTime? uploadedAt,
  }) {
    return Ebook(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  @override
  String toString() => 'Ebook(id: $id, title: $title, author: $author)';
}
