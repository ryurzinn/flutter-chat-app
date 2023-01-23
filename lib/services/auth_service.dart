
import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/usuario.dart';

 class AuthService with ChangeNotifier{

 Usuario? usuario;
 bool _autenticando = false;

// Create storage
 final _storage = const FlutterSecureStorage();


 bool get autenticando => _autenticando;
 set autenticando(bool valor){
  _autenticando = valor;
  notifyListeners();
 }

 // Getters del token de forma estatica 
 static Future getToken() async{
 const storage = FlutterSecureStorage();
 final token = await storage.read(key: 'token');
 return token;
  

 }  
 // Getters del token de forma estatica 
 static Future<void> deleteToken () async{
 const storage = FlutterSecureStorage();
 await storage.delete(key: 'token');

 }  


  Future login(String email, String password) async{

    autenticando = true;

  final data  = {
    'email' : email,
    'password' : password,
  };

  final uri = Uri.parse('${ Environment.apiUrl }/login');
    final response = await http.post(uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    autenticando = false;

  if(response.statusCode == 200) {
 final loginResponse = loginResponseFromMap(response.body);
 usuario = loginResponse.usuario;

  _guardarToken(loginResponse.token);

 return true;

  }else{

 return false;
  }
   
}

  Future register(String nombre, String email, String password) async{
      autenticando = true;

      final data  = {
        'nombre' : nombre,
        'email' : email,
        'password' : password,
      };

       final uri = Uri.parse('${ Environment.apiUrl }/login/new');
    final response = await http.post(uri, 
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );
     
      autenticando = false;
      if(response.statusCode == 200) {
    final loginResponse = loginResponseFromMap(response.body);
    usuario = loginResponse.usuario;

      _guardarToken(loginResponse.token);

    return true;

      }else{
        final respBody = jsonDecode(response.body);
        return respBody['msg'];
      }
      }

    Future<bool> isLoggedIn() async {

    final token = await _storage.read(key: 'token') ?? '';

    final uri = Uri.parse('${ Environment.apiUrl }/login/renew');
    final response = await http.get(uri, 
      headers: { 
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
     
  
      if(response.statusCode == 200) {
    final loginResponse = loginResponseFromMap(response.body);
    usuario = loginResponse.usuario;

      _guardarToken(loginResponse.token);

    return true;

      }else{
        logout();
        return false;
      }
      }



    Future _guardarToken (String token) async{
    return await _storage.write(key: 'token', value: token);

 }

  Future logout( ) async{
   return await _storage.delete(key: 'token');
  }

}