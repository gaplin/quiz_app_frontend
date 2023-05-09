import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_frontend/components/custom_app_bar.dart';
import 'package:quiz_app_frontend/model/credentials.dart';
import 'package:quiz_app_frontend/model/login_state.dart';
import 'package:quiz_app_frontend/pages/quizzes_page.dart';

import '../api_client/rest_client.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final client = RestClient();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        color: theme.colorScheme.primaryContainer,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: TextFormField(
                    controller: loginController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "login"),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 5 ||
                          value.length > 20) {
                        return 'Login must have more than 4 and less than 21 characters';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 8 ||
                          value.length > 20) {
                        return 'Password must have more than 7 and less than 21 characters';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final credentials = Credentials(
                            loginController.text,
                            passwordController.text,
                          );
                          final token = await client.login(credentials);
                          if (token == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Invalid login or password')),
                              );
                            }
                          } else {
                            if (context.mounted) {
                              Provider.of<LoginState>(context, listen: false)
                                  .setToken(token);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => QuizzesPage(),
                                ),
                              );
                            }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
