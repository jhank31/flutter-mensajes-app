import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/global/environments.dart';
import 'package:flutter_chat_app/src/models/login_response.dart';
import 'package:flutter_chat_app/src/models/usuario.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  //crear instancia del storage
  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool data) {
    _autenticando = data;
    notifyListeners();
  }

  //Getter del token de manera statica
  static Future getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  //eliminar el token
  static Future deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Environment.apiUrl}/login');
    final res = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;
      _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final uri = Uri.parse('${Environment.apiUrl}/login/new');
    final res = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;
      _guardarToken(loginResponse.token);

      return true;
    } else {
      final resBody = jsonDecode(res.body);
      return resBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/login/renew');
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': token.toString()
    });

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;
      _guardarToken(loginResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  // ignore: unused_element
  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
