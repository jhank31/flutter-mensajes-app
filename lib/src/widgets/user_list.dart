import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/models/usuario.dart';

class UsersList extends StatelessWidget {
  final Usuario user;
  const UsersList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.nombre),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[200],
        child: Text(user.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
