class Question {
  final String text;
  final List<String> correctAnswers;
  final List<String> wrongAnswers;

  const Question({
    required this.text,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      correctAnswers:
          (json['correctAnswers'] as List).map((e) => e as String).toList(),
      text: json['text'],
      wrongAnswers:
          (json['wrongAnswers'] as List).map((e) => e as String).toList(),
    );
  }
}
