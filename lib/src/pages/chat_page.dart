import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool estaEscribiendo = false;
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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

    print(texto);

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      estaEscribiendo;
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
