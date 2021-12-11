import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Blo_usuario extends StatefulWidget {
  @override
  Blo_usuarioApp createState() => Blo_usuarioApp();
}

class Blo_usuarioApp extends State<Blo_usuario> {
  TextEditingController correo = TextEditingController();
  TextEditingController Pass = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  int flang = 0;

  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot user = await ref.get();
      if (user.docs.length != 0) {
        for (var cursor in user.docs) {
          if (cursor.get("Correo") == correo.text) {
            if (cursor.get("Password") == Pass.text) {
              //print(cursor.get("NombreUsuario"));
              flang = 1;
              //print(cursor.id);
              try {
                await firebase.collection("Usuarios").doc(cursor.id).set({
                  "NombreUsuario": cursor.get("NombreUsuario"),
                  "Correo": cursor.get("Correo"),
                  "Telefono": cursor.get("Telefono"),
                  "Password": cursor.get("Password"),
                  "Estrado": false
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
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        title: Text("Cambio de Contraseña"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 40, top: 40, right: 40, bottom: 10),
              child: TextField(
                controller: correo,
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Correo",
                    hintText: "Digite su Correo"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 0, right: 40, bottom: 10),
              child: TextField(
                obscureText: true,
                controller: Pass,
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Contraseña",
                    hintText: "Digite su Contraseña Actual"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 0, right: 40, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 45),
                  shadowColor: Colors.amber,
                ),
                onPressed: () {
                  validarDatos();
                },
                child: Text("Cambiar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
