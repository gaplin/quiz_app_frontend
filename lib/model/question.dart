class Question {
  final String text;
  final List<String> answers;
  final int correctAnswer;

  const Question({
    required this.text,
    required this.answers,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        answers: (json['answers'] as List).map((e) => e as String).toList(),
        text: json['text'],
        correctAnswer: json['correctAnswer']);
  }
}
