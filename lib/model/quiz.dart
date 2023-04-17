import 'package:quiz_app_frontend/model/question.dart';

class Quiz {
  final String id;
  final String title;
  final String category;
  final String author;
  final List<Question> questions;

  const Quiz({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      author: json['author'],
      questions: (json['questions'] as List)
          .map((e) => (Question.fromJson(e)))
          .toList(),
    );
  }
}
