import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget{

   const BotonAzul({
    Key? key, 
    required this.text, 
    required this.onPressed
    }) : super(key: key);

  final String text;
  final Function()? onPressed;

@override 
  Widget build(BuildContext context) {
         return MaterialButton(
            elevation: 2,
            highlightElevation: 5,
            color: Colors.blue,
            shape: const StadiumBorder(),
            onPressed: () => onPressed!(),
            child: const SizedBox(
             width: double.infinity,
             height: 55,
             child: Center(
              child: Text('Ingrese', style: TextStyle(color: Colors.white, fontSize: 17 ),),
             ),
            ),
            
            );

            
  }}