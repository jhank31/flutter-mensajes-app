import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/models/messages_response.dart';
import 'package:flutter_chat_app/src/services/auth_service.dart';
import 'package:flutter_chat_app/src/services/chat_service.dart';
import 'package:flutter_chat_app/src/services/socket_service.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late ChatService chatServices;
  late SocketServices socketServices;
  late AuthService authService;
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    chatServices = Provider.of<ChatService>(context, listen: false);
    socketServices = Provider.of<SocketServices>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketServices.socket.on('mensaje-personal', _escucharMensaje);
    _cargarHistorial(chatServices.usuarioPara.uid);
    super.initState();
  }

  void _cargarHistorial(String uid) async {
    List<Mensaje> chat = await chatServices.getChat(uid);

    final history = chat.map((m) => ChatMessage(
        text: m.mensaje,
        uid: m.de,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic data) {
    ChatMessage message = ChatMessage(
        text: data('mensaje'),
        uid: data('de'),
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300)));
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  bool estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue[400],
            )),
        elevation: 1,
        backgroundColor: Colors.white,
        title: const AppBarChat(),
      ),
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) => _messages[index],
            itemCount: _messages.length,
            reverse: true,
          )),
          const Divider(
            height: 1,
          ),
          Container(color: Colors.white, child: inputChat())
        ],
      ),
    );
  }

  Widget inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String texto) {
              setState(() {
                if (texto.trim().isNotEmpty) {
                  estaEscribiendo = true;
                } else {
                  estaEscribiendo;
                }
              });
            },
            decoration: const InputDecoration.collapsed(
              hintText: 'Enviar mensaje',
            ),
            focusNode: _focusNode,
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                    child: const Text('Enviar'))
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: const Icon(Icons.send),
                        onPressed: estaEscribiendo
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: texto,
      uid: authService.usuario!.uid,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      estaEscribiendo;
    });
    socketServices.emit('mensaje-personal', {
      'de': authService.usuario!.uid,
      'para': chatServices.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketServices.socket.off('mensaje-personal');

    super.dispose();
  }
}
