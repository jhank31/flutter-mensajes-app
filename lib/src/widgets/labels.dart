// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String data;
  final String ruta;
  final String title;

  const Labels({required this.data, required this.ruta, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
           Text(
            title,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(data,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
