import 'package:flutter/material.dart';

import '../api_client/rest_client.dart';
import '../components/custom_app_bar.dart';
import '../components/quizzes_grid.dart';
import '../model/quiz_base.dart';

class QuizzesPage extends StatefulWidget {
  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  final RestClient client = RestClient();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    var quizzesFuture = client.getAllQuizzes();
    return FutureBuilder<List<QuizBase>>(
      future: quizzesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var quizzes = snapshot.data!;
          return Scaffold(
            appBar: CustomAppBar(),
            body: Container(
              color: theme.colorScheme.primaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Choose quiz',
                    style: style,
                  ),
                  Flexible(
                    child: QuizzesGrid(
                      quizzes: quizzes,
                    ),
                  ),
                ],
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
}
