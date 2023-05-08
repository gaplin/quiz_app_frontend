import 'package:json_annotation/json_annotation.dart';

import 'create_question_dto.dart';

part 'create_quiz_dto.g.dart';

@JsonSerializable()
class CreateQuizDTO {
  final String title;
  final String category;
  final List<CreateQuestionDTO> questions;

  CreateQuizDTO(this.title, this.category, this.questions);

  factory CreateQuizDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateQuizDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuizDTOToJson(this);
}
