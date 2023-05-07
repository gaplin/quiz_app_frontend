import 'package:json_annotation/json_annotation.dart';

part 'quiz_base.g.dart';

@JsonSerializable()
class QuizBase {
  final String id;
  final String title;
  final String category;
  final String author;
  final int numberOfQuestions;

  QuizBase(
    this.id,
    this.title,
    this.category,
    this.author,
    this.numberOfQuestions,
  );

  factory QuizBase.fromJson(Map<String, dynamic> json) =>
      _$QuizBaseFromJson(json);

  Map<String, dynamic> toJson() => _$QuizBaseToJson(this);
}
