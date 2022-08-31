import 'package:flutter_chat_app/src/models/usuarios_response.dart';
import 'package:flutter_chat_app/src/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_app/src/models/usuario.dart';

import '../../global/environments.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
