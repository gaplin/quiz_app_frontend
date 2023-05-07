import 'dart:convert';
import 'dart:io';

import 'package:quiz_app_frontend/model/create_user_fields.dart';
import 'package:quiz_app_frontend/model/credentials.dart';

import '../consts.dart';
import '../model/quiz.dart';
import 'package:http/http.dart' as http;

import '../model/quiz_base.dart';

class RestClient {
  final String _apiUrl = Consts.apiUrl;
  final String? _token;

  RestClient(this._token);

  Future<List<QuizBase>> getAllQuizzes() async {
    final response = await http.get(Uri.https(_apiUrl, 'quizzes/baseInfo'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((quiz) => QuizBase.fromJson(quiz)).toList();
    } else {
      throw Exception('Failed to load all quizzes');
    }
  }

  Future<Quiz> getShuffledQuizById(String id) async {
    var queryParams = {
      'shuffle': 'true',
    };
    var path = 'quizzes/$id';
    var uri = Uri.https(_apiUrl, path, queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Quiz.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load quiz');
    }
  }

  Future<String> getRole(String id) async {
    final path = '/users/$id/role';
    final uri = Uri.https(_apiUrl, path);
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $_token'};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get role for userId $id');
    }
  }

  Future<String?> register(CreateUserFields fields) async {
    const path = '/users';
    final uri = Uri.https(_apiUrl, path);
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    final body = jsonEncode(fields.toJson());

    final response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<String?> login(Credentials credentials) async {
    const path = '/login';
    final uri = Uri.https(_apiUrl, path);
    final body = jsonEncode(credentials.toJson());
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    final response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
