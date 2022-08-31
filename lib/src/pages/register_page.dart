// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/helpers/mostrar_alerta.dart';
import 'package:flutter_chat_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/socket_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(
                    titulo: 'Registro',
                  ),
                  _Form(),
                  const Labels(
                    data: 'Ingresa con tu cuenta',
                    ruta: 'login',
                    title: '¿Ya tienes cuenta?',
                  ),
                  TerminosCondiciones()
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketServices>(context);
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            textController: nameCtrl,
            icon: Icons.perm_identity,
            placeHolder: 'Nombre',
            keyboardType: TextInputType.text,
          ),
          CustomInput(
            textController: emailCrl,
            icon: Icons.email_outlined,
            placeHolder: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            textController: passwordCtrl,
            icon: Icons.lock_outline,
            placeHolder: 'Contraseña',
            isPassword: true,
          ),
          BotonAzul(
            onPressed: authServices.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final registerOk = await authServices.register(
                        nameCtrl.text.trim(),
                        emailCrl.text.trim(),
                        passwordCtrl.text.trim());
                    if (registerOk == true) {
                      //conectar al socketServer
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Registro incorrecto', registerOk);
                    }
                  },
            text: 'Registrar',
          )
        ],
      ),
    );
  }
}
