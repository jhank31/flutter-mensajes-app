// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/pages/login_page.dart';
import 'package:flutter_chat_app/src/pages/usuarios_pages.dart';
import 'package:flutter_chat_app/src/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: checkLoginState(context),
          builder: (BuildContext context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Espere..')
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      //conectar al socketserver
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const UsuariosPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    }
  }
}
