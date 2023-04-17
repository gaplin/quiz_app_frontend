import 'dart:convert';

import '../consts.dart';
import '../model/quiz.dart';
import 'package:http/http.dart' as http;

class RestClient {
  final String _apiUrl = Consts.apiUrl;

  Future<List<Quiz>> getAllQuizzes() async {
    final response = await http.get(Uri.https(_apiUrl, 'quizzes'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((quiz) => Quiz.fromJson(quiz)).toList();
    } else {
      throw Exception('Failed to load all quizzes');
    }
  }
}
