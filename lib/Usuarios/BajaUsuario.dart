import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Token.dart';

class BajaUsuario extends StatefulWidget {
  @override
  BajaUsuarioApp createState() => BajaUsuarioApp();
}

class BajaUsuarioApp extends State<BajaUsuario> {
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController direccion = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  String correo1 = "";
  String idDoc = "";
  int flang = 0;
  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot user = await ref.get();
      if (user.docs.length != 0) {
        for (var cursor in user.docs) {
          if (cursor.get("Correo") == correo.text) {
            if (cursor.get("Password") == pass.text) {
              flang = 1;
              try {
                await firebase.collection("Usuarios").doc(cursor.id).set({
                  "NombreUsuario": cursor.get("NombreUsuario"),
                  "Correo": cursor.get("Correo"),
                  "Telefono": cursor.get("Telefono"),
                  "Password": pass.text,
                  "Estado": false
                });
              } catch (e) {
                print(e);
              }
            }
          }
        }
        if (flang == 0) {}
      } else {
        print("no hay elementos en la coleccion");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ///++++++++++++++++++++++++++++
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        title: Text("Inactivar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('image/login.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 30, right: 5, bottom: 5),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Correo',
                  hintText: 'Digite el correo',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 30, right: 5, bottom: 5),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Contraseña',
                  hintText: 'Digite su contraseña',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 30, right: 5, bottom: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(100, 50)),
                onPressed: () {
                  validarDatos();
                },
                child: Text("Enviar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
