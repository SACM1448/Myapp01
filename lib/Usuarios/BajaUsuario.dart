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
  bool estado = false;
  validarDatos1() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario = await ref.get();

      if (usuario.docs.length != 0) {
        print(usuario.docs.length);
        int flag = 0;
        for (var cursor in usuario.docs) {
          if (cursor.get("Correo") == correo.text) {
            if (cursor.get("Password") == pass.text &&
                cursor.get("Estado") == true) {
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
  validarDatos() async {
    try {
      CollectionReference ref =
      FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario = await ref.get();

      if (usuario.docs.length != 0) {
        for (var cursor in usuario.docs) {
          if (cursor.get("Correo") == correo.text) {
            nombre.text = cursor.get("nombreUsuario");
            telefono.text = cursor.get("Telefono");
            direccion.text = cursor.get("Direccion");
            this.idDoc = cursor.id;
            this.correo1 = cursor.get("Correo");
            this.pass = cursor.get("Password");
          }
        }
      } else {
        print("No hay elementos en la colección ");
      }
    } catch (e) {
      print(e);
    }
  }
  modificarDatos() async {
    try {
      await firebase.collection("Usuarios").doc(idDoc).set({
        "nombreUsuario": nombre.text,
        "Correo": this.correo1,
        "Telefono": telefono.text,
        "Password": pass,
        "Direccion": direccion.text,
        "Estado": false
      });
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
                  validarDatos1();
                  //validarDatos();
                  modificarDatos();
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
