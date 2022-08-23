import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/pages/chat_page.dart';
import 'package:flutter_chat_app/src/pages/loading_page.dart';
import 'package:flutter_chat_app/src/pages/login_page.dart';
import 'package:flutter_chat_app/src/pages/register_page.dart';
import 'package:flutter_chat_app/src/pages/usuarios_pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios' : (_) => const UsuariosPage(),
  'chat' : (_) => const ChatPage(),
  'login' : (_) => const LoginPage(),
  'register' : (_) => const RegisterPage(),
  'loading' : (_) => const LoadingPage(),
};
