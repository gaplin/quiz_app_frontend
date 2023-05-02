import 'package:flutter/material.dart';
import 'package:quiz_app_frontend/components/quizzes_grid.dart';

import '../api_client/rest_client.dart';
import '../model/quiz_base.dart';

class QuizzesPage extends StatefulWidget {
  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  final RestClient client = RestClient();
  late Future<List<QuizBase>> quizzes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: QuizzesGrid(
        quizzes: quizzes,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    quizzes = client.getAllQuizzes();
  }
}
