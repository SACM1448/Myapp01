import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Token.dart';

class Login extends StatefulWidget {
  @override
  LoginApp createState() => LoginApp();
}

//
class LoginApp extends State<Login> {
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();
  //final firebase=FirebaseFirestore.instance;

  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario = await ref.get();

      if (usuario.docs.length != 0) {
        print(usuario.docs.length);
        int flag = 0;
        for (var cursor in usuario.docs) {

          if (cursor.get("Correo") == correo.text) {
            if (cursor.get("Password") == pass.text && cursor.get("Estado") == true) {
              flag = 1;
              Token tk = new Token();
              tk.guardarToken(cursor.id.toString());
              Navigator.of(context).pop();
            }
          }
        }
        if (flag == 0) {
          mensaje("No encotrado", "No se encontró el usuario");
        }
      } else {
        print("No hay elementos en la colección ");
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
        title: Text("Ingreso de clientes"),
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

  void mensaje(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    Text("Aceptar", style: TextStyle(color: Colors.blueGrey)),
              )
            ],
          );
        });
  }
}
