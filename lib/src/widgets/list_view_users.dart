import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/widgets/widgets.dart';

import '../models/usuario.dart';

class ListViewUsers extends StatelessWidget {
  final List<Usuario> usuarios;
  const ListViewUsers({
    Key? key,
    required this.usuarios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => UsersList(
              user: usuarios[i],
            ),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: usuarios.length);
  }
}
