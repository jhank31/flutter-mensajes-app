import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/models/usuario.dart';
import 'package:flutter_chat_app/src/services/auth_service.dart';
import 'package:flutter_chat_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'test1@gmail.com', online: true),
    Usuario(uid: '2', nombre: 'Luis', email: 'test2@gmail.com', online: false),
    Usuario(uid: '3', nombre: 'Andres', email: 'test3@gmail.com', online: true)
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            usuario!.nombre,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(
              Icons.check_circle,
              color: Colors.blue,
            ),
            /* child: const Icon(Icons.offline_bolt, color: Colors.red,), */
          )
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black54,
          ),
          onPressed: () {
            //desconectarnos del socketServer
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
      ),
      body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _cargarUsuarios,
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: (Colors.blue.shade400),
          ),
          child: ListViewUsers(usuarios: usuarios)),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
}
