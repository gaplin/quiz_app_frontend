class QuizBase {
  final String id;
  final String title;
  final String category;
  final String author;

  const QuizBase({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
  });

  factory QuizBase.fromJson(Map<String, dynamic> json) {
    return QuizBase(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      author: json['author'],
    );
  }
}
