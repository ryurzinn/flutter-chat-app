import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});


  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _messages = [

  ];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[400],
              maxRadius: 14,
              child: const Text('Te', style: TextStyle(fontSize: 12),),
            ),
              const SizedBox(height: 3,),
              const Text('Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder:  (_, i) => _messages[i],
              reverse: true,
              )
            ),
            const Divider(height: 1,),

            // TODO: Caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
        ],
      ),
   );
  }

  Widget _inputChat( ) {

    return SafeArea(child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [

          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSumbit,
              onChanged: (String texto){
              setState(() {
                if(texto.trim().isNotEmpty){
                  _estaEscribiendo = true;
                }else{
                  _estaEscribiendo = false;
                }
              });  
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Enviar mensaje'
                
                
                ),
                focusNode: _focusNode,
            ) 
            ),


            // Boton de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
              ? CupertinoButton(
                onPressed: _estaEscribiendo 
                    ? () =>  _handleSumbit(_textController.text.trim())
                    : null,
                child: const Text('Enviar'),
                 )

                 :Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child:  IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                     icon: const Icon(Icons.send),
                    onPressed: _estaEscribiendo 
                    ? () =>  _handleSumbit(_textController.text.trim())
                    : null,
                    ),
                  ),


            )
            )
        ],
      ),
    ));

  }

  _handleSumbit(String texto){

    if(texto.isEmpty) return;

    _focusNode.requestFocus();
    _textController.clear();

    final newMessage = ChatMessage(
      texto: texto,
       uid: '123',
       animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 400)),
       
       );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

  setState(() {
    _estaEscribiendo = false;
  });

  }

  @override
  void dispose() {
    // TODO: Off del socket

    for(ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }

}