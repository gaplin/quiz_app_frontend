import 'package:flutter/material.dart';
import 'package:quiz_app_frontend/view/quizzes_grid_view.dart';

import '../api_client/rest_client.dart';
import '../model/quiz.dart';

class QuizzesPage extends StatefulWidget {
  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  final RestClient client = RestClient();
  late Future<List<Quiz>> quizzes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: QuizzesGridView(
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
