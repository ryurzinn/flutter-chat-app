

import 'package:chat_app/pages/chat_page.dart';

import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

import '../pages/loading_page.dart';
import '../pages/login_page.dart';

  Map<String, Widget Function(BuildContext)>appRoutes = {

  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  
};