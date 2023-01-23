// To parse this JSON data, do
//
//     final usuario = usuarioFromMap(jsonString);

import 'dart:convert';

Usuario usuarioFromMap(String str) => Usuario.fromMap(json.decode(str));

String usuarioToMap(Usuario data) => json.encode(data.toMap());

class Usuario {
    Usuario({
        required this.nombre,
        required this.email,
        required this.online,
        required this.uid,
    });

    String nombre;
    String email;
    bool online;
    String uid;

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "email": email,
        "online": online,
        "uid": uid,
    };
}
