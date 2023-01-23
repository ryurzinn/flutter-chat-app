import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/mostrar_alerta.dart';
import '../widgets/btn_azul.dart';
import '../widgets/custom_input.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
                const Logo(titulo: 'Messenger',),
                _Form(),
                 const Labels(
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subtitulo: 'Crea una ahora!',
                  ),
                  
               const Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w300, ),)
                
              ],
            ),
          ),
        ),
      )
   );
  }
}


 class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

 class __FormState extends State<_Form>{

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children:  [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
         
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
         
          BotonAzul(
            text: 'Ingrese',
            onPressed: authService.autenticando ? null : () async{
              FocusScope.of(context).unfocus();
             final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim() );

             if(loginOk){
              // TODO: Conectar a nuestro socket server
              Navigator.pushReplacementNamed(context, 'usuarios');
             }else{
              // Mostrar alerta
              mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales');
             }
          }, 
          ),
        ],
      ),
    );
  }
 }


 