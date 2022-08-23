import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                    titulo: 'Messenger',
                  ),
                  _Form(),
                  const Labels(
                    data: 'Crea una ahora',
                    ruta: 'register',
                    title: '¿No tienes cuenta?',
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
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            textController: emailCtrl,
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
            onPressed: () {},
            text: 'Ingrese',
          )
        ],
      ),
    );
  }
}
