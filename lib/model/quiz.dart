import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app_frontend/model/question.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  final String id;
  final String title;
  final String category;
  final String author;
  final List<Question> questions;

  Quiz(
    this.id,
    this.title,
    this.category,
    this.author,
    this.questions,
  );

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
