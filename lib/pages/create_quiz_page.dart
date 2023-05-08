import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_frontend/components/custom_app_bar.dart';
import 'package:quiz_app_frontend/components/custom_text_field.dart';
import 'package:quiz_app_frontend/components/question_form.dart';
import 'package:quiz_app_frontend/model/create_quiz_dto.dart';
import 'package:quiz_app_frontend/model/login_state.dart';
import 'package:quiz_app_frontend/pages/quizzes_page.dart';

import '../api_client/rest_client.dart';

class CreateQuizPage extends StatefulWidget {
  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final _formKey = GlobalKey<FormState>();
  final client = RestClient();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final List<QuestionForm> questions = [QuestionForm()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<LoginState>(builder: (context, loginState, child) {
      if (loginState.token == null) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => QuizzesPage(),
                )));
      }
      return Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          color: theme.colorScheme.primaryContainer,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: questions.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return CustomTextField(
                          controller: titleController,
                          label: "Title",
                          minSymbols: 1,
                          maxSymbols: 100,
                        );
                      }
                      if (index == 1) {
                        return CustomTextField(
                          controller: categoryController,
                          label: "Category",
                          minSymbols: 1,
                          maxSymbols: 100,
                        );
                      }
                      return questions[index - 2];
                    }),
                _getButtons(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final quiz = CreateQuizDTO.fromForm(
                            titleController.text,
                            categoryController.text,
                            questions,
                          );
                          final client = RestClient.withToken(loginState.token);
                          final success = await client.createQuiz(quiz);
                          if (context.mounted) {
                            if (success) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => QuizzesPage(),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sorry, something went wrong'),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _getButtons() {
    List<Widget> buttons = [];
    buttons.add(
      ElevatedButton(
        onPressed: () {
          setState(() {
            questions.add(QuestionForm());
          });
        },
        child: Text('Add Question'),
      ),
    );
    if (questions.length > 1) {
      buttons.add(SizedBox(width: 20));
      buttons.add(ElevatedButton(
          onPressed: () {
            setState(() {
              questions.removeLast();
            });
          },
          child: Text('Remove question')));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons,
    );
  }
}
