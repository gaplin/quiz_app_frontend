import 'package:flutter/material.dart';
import 'package:quiz_app_frontend/components/quizzes_grid.dart';

import '../api_client/rest_client.dart';
import '../components/custom_app_bar.dart';
import '../model/quiz_base.dart';

class QuizzesPage extends StatefulWidget {
  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  final RestClient client = RestClient();
  late Future<List<QuizBase>> quizzesFuture;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<List<QuizBase>>(
      future: quizzesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var quizzes = snapshot.data!;
          return Scaffold(
            appBar: CustomAppBar(),
            body: Container(
              color: theme.colorScheme.primaryContainer,
              child: QuizzesGrid(
                quizzes: quizzes,
              ),
            ),
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
    quizzesFuture = client.getAllQuizzes();
  }
}
