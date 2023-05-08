import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_frontend/components/custom_app_bar.dart';
import 'package:quiz_app_frontend/model/create_user_fields.dart';
import 'package:quiz_app_frontend/model/login_state.dart';
import 'package:quiz_app_frontend/pages/quizzes_page.dart';

import '../api_client/rest_client.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final client = RestClient();
  TextEditingController userNameController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatedPasswordController = TextEditingController();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "UserName"),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 5 ||
                          value.length > 20) {
                        return 'Username must have more than 4 and less than 21 characters';
                      }
                      return null;
                    },
                  ),
                ),
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
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: repeatedPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Repeated password"),
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords must match';
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
                          final createUserFields = CreateUserFields(
                            loginController.text,
                            passwordController.text,
                            userNameController.text,
                          );
                          final token = await client.register(createUserFields);
                          if (token == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Login already taken')),
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
