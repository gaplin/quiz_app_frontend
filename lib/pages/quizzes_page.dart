import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_frontend/components/quizzes_grid.dart';

import '../api_client/rest_client.dart';
import '../components/custom_app_bar.dart';
import '../model/login_state.dart';
import '../model/quiz_base.dart';

class QuizzesPage extends StatefulWidget {
  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  late Future<List<QuizBase>> quizzesFuture;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    return Consumer<LoginState>(
      builder: (context, loginState, child) {
        final RestClient client = RestClient(loginState.token);
        quizzesFuture = client.getAllQuizzes();
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
      },
    );
  }
}
