import 'package:flutter_chat_app/src/models/messages_response.dart';
import 'package:flutter_chat_app/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/models/usuario.dart';

import '../../global/environments.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future getChat(String usuarioId) async {
    final resp = await http
        .get(Uri.parse('${Environment.apiUrl}/mensajes/$usuarioId'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final mensajesResponse = messagesResponseFromJson(resp.body);

    return mensajesResponse.mensajes;
  }
}
