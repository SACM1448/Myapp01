import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemRegister extends StatefulWidget {
  final String idTienda;
  ItemRegister(this.idTienda);

  @override
  ItemRegisterApp createState() => ItemRegisterApp();
}

//
class ItemRegisterApp extends State<ItemRegister> {
  @override
  TextEditingController nombre = TextEditingController();
  TextEditingController precio = TextEditingController();
  TextEditingController descripcion = TextEditingController();

  final firebase = FirebaseFirestore.instance;

  registrarProducto() async {
    try {
      await firebase.collection("Productos").doc().set({
        "Nombre": nombre.text,
        "Precio":double.parse(precio.text),
        "Descripcion": descripcion.text,
        "TiendaId": widget.idTienda,
        "Estado": true
      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    ///++++++++++++++++++++++++++++
    return Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          title: Text("Registro Producto"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('image/icono.png'),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                child: TextField(
                  controller: nombre,
                  decoration: InputDecoration(
                    labelText: "Nombre Producto",
                    hintText: "Digite nombre del producto",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                // RUTA IMÁMGEN
                child: TextField(
                  controller: precio,
                  decoration: InputDecoration(
                      labelText: "Precio final",
                      hintText: "Digite precio",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                // DESCRIPCIÓN TIENDA
                child: TextField(
                  controller: descripcion,
                  decoration: InputDecoration(
                      labelText: "Descripción",
                      hintText: "Digite Descripción del producto",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      registrarProducto();
                      nombre.clear();
                      precio.clear();
                      descripcion.clear();
                    },
                    child: Text("Registrar"),
                  )),
            ],
          ),
        ));
  }
}
