class QuizBase {
  final String id;
  final String title;
  final String category;
  final String author;
  final int numberOfQuestions;

  const QuizBase({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.numberOfQuestions,
  });

  factory QuizBase.fromJson(Map<String, dynamic> json) {
    return QuizBase(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        author: json['author'],
        numberOfQuestions: json['numberOfQuestions']);
  }
}
