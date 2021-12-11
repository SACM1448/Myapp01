import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Tiendas/ShopOne.dart';
import 'Tiendas/Tienda.dart';

class buscar extends StatefulWidget {
  final String searchWord;
  buscar(this.searchWord);
  @override
  BuscarApp createState() => BuscarApp();
}

//
class BuscarApp extends State<buscar> {
  Tienda tiendaObjeto = new Tienda();
  @override
  Widget build(BuildContext context) {
    ///++++++++++++++++++++++++++++
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        title: Text("Registro de búsqueda"),
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("Tiendas").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              // print(widget.searchWord);
              return ListView.builder(
                itemCount: snapshot.data!.docs.length, // define las iteraciones
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data!.docs[index]
                      .get("nombreTienda")
                      .toString()
                      .toUpperCase()
                      .contains(widget.searchWord.toUpperCase())) {
                    return new Card(
                      child: new Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(snapshot.data!.docs[index]
                                          .get("nombreTienda"))),
                                  Text(
                                    snapshot.data!.docs[index].get("descrip"),
                                    style: TextStyle(
                                      color: Colors.green[500],
                                    ),
                                  ),
                                ],
                              )),
                              Container(
                                width: 80,
                                height: 80,
                                child: Image.asset('image/' +
                                    snapshot.data!.docs[index].get("ruta")),
                              ),
                              IconButton(
                                onPressed: () {
                                  tiendaObjeto.idTienda =
                                      snapshot.data!.docs[index].id;
                                  tiendaObjeto.nombre = snapshot.data!.docs[index]
                                      .get("nombreTienda");
                                  tiendaObjeto.descripcion =
                                      snapshot.data!.docs[index].get("descrip");
                                  tiendaObjeto.imagen =
                                      snapshot.data!.docs[index].get("ruta");
                                  tiendaObjeto.website =
                                      snapshot.data!.docs[index].get("webSite");

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ShopOne(tiendaObjeto)));
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.blueGrey,
                                  size: 45,
                                ),
                              )
                            ]),
                          )
                        ],
                      ),
                    );
                  } else {
                    return new Card();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
