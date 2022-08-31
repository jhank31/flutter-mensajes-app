import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/services/chat_service.dart';
import 'package:provider/provider.dart';

class AppBarChat extends StatelessWidget {
  const AppBarChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final usuario = chatService.usuarioPara;

    return Center(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[300],
            maxRadius: 15,
            child: Text(
              usuario.nombre.substring(0, 2),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            usuario.nombre,
            style: const TextStyle(color: Colors.black87, fontSize: 12),
          )
        ],
      ),
    );
  }
}
