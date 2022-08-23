// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const BotonAzul({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      color: Colors.blue,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child:  SizedBox(
        height: 55,
        width: double.infinity,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
    );
  }
}
