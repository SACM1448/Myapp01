import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Modificartienda extends StatefulWidget {
  @override
  ModificartiendaApp createState() => ModificartiendaApp();
}

//
class ModificartiendaApp extends State<Modificartienda> {
  TextEditingController webSite = TextEditingController();
  TextEditingController nombreTienda = TextEditingController();
  TextEditingController ruta = TextEditingController();
  TextEditingController descrip = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  String Web1 = "";
  String idDoc = "";

  validarDatos() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Tiendas");
      QuerySnapshot tienda = await ref.get();

      if (tienda.docs.length != 0) {
        for (var cursor in tienda.docs) {
          if (cursor.get("webSite") == webSite.text) {
            nombreTienda.text = cursor.get("nombreTienda");
            ruta.text = cursor.get("ruta");
            descrip.text = cursor.get("descrip");
            this.idDoc = cursor.id;
            this.Web1 = cursor.get("webSite");
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
      await firebase.collection("Tiendas").doc(idDoc).set({
        "nombreTienda": nombreTienda.text,
        "webSite": this.Web1,
        "ruta": ruta.text,
        "descrip": descrip.text,
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
        title: Text("Actualizar Tienda"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: webSite,
                decoration: InputDecoration(
                  labelText: "WebSite",
                  hintText: "Digite pagina web",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                    validarDatos();
                  },
                  child: Text("Buscar tienda"),
                )),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              // RUTA IMÁMGEN
              child: TextField(
                controller: nombreTienda,
                decoration: InputDecoration(
                    labelText: "Nombre Tienda",
                    hintText: "Digite nombre de la Tienda",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: ruta,
                decoration: InputDecoration(
                    labelText: "Ruta de la Imagen",
                    hintText: "Digite la Ruta",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: TextField(
                controller: descrip,
                decoration: InputDecoration(
                    labelText: "Descripcion",
                    hintText: "Digite la Descripcion",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 0),
              child: ElevatedButton(
                onPressed: () {
                  modificarDatos();
                },
                child: Text("Modificar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
