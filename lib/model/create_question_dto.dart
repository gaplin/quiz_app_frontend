import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app_frontend/components/question_form.dart';

part 'create_question_dto.g.dart';

@JsonSerializable()
class CreateQuestionDTO {
  final String text;
  final List<String> answers;
  final int correctAnswer;

  CreateQuestionDTO(this.text, this.answers, this.correctAnswer);

  factory CreateQuestionDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateQuestionDTOFromJson(json);

  factory CreateQuestionDTO.fromForm(QuestionForm questionsForm) {
    final text = questionsForm.questionTextController.text;
    const correctAnswer = 0;
    final answers = <String>[];
    answers.add(questionsForm.correctAnswerController.text);
    answers.addAll(questionsForm.wrongAnswerControllers.map((x) => x.text));
    return CreateQuestionDTO(text, answers, correctAnswer);
  }

  Map<String, dynamic> toJson() => _$CreateQuestionDTOToJson(this);
}
