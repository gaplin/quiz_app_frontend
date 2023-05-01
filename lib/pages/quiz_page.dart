import 'package:flutter/material.dart';

import '../api_client/rest_client.dart';
import '../model/question.dart';
import '../model/quiz.dart';

class QuizPage extends StatefulWidget {
  final String quizId;

  const QuizPage({super.key, required this.quizId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final RestClient client = RestClient();
  late Future<Quiz> quiz;
  var questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quiz>(
      future: quiz,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _QuestionsGrid(
            questions: snapshot.data!.questions,
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Text("");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    quiz = client.getShuffledQuizById(widget.quizId);
  }
}

class _QuestionsGrid extends StatelessWidget {
  final List<Question> questions;
  const _QuestionsGrid({
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return Text(questions[index].text);
      },
    );
  }
}
