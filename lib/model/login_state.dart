import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quiz_app_frontend/api_client/rest_client.dart';

class LoginState extends ChangeNotifier {
  String? _token;
  String? _userId;
  String? _login;
  String? _userName;
  String? _role;

  String? get token => _token;
  String? get userId => _userId;
  String? get login => _login;
  String? get userName => _userName;
  String? get role => _role;

  Future setToken(String? token) async {
    _token = token;
    if (_token == null) {
      _userId = null;
      _login = null;
      _userName = null;
      _role = null;
    } else {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
      _userId = decodedToken['Id'];
      _login = decodedToken['sub'];
      _userName = decodedToken['name'];
      final RestClient client = RestClient.withToken(token);
      _role = await client.getRole(_userId!);
    }
    notifyListeners();
  }
}
