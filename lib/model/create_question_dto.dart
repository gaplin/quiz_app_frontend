import 'package:json_annotation/json_annotation.dart';

part 'create_question_dto.g.dart';

@JsonSerializable()
class CreateQuestionDTO {
  final String text;
  final List<String> answers;
  final int correctAnswer;

  CreateQuestionDTO(this.text, this.answers, this.correctAnswer);

  factory CreateQuestionDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateQuestionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuestionDTOToJson(this);
}
