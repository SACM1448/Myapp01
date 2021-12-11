import 'package:flutter/material.dart';

import 'Shop.dart';
import 'ShopRegister.dart';
import 'ModificarTienda.dart';

class GestionTiendas extends StatefulWidget {
  @override
  GestionTiendasApp createState() => GestionTiendasApp();
}

//
class GestionTiendasApp extends State<GestionTiendas> {
  TextEditingController busqueda = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ///++++++++++++++++++++++++++++
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        title: Text("Gestión Tiendas"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(35),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('image/tienda.png'),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:10, right: 12, left: 20, bottom: 5),
                  child: Center(
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(145, 50)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ShopRegister()));
                      },
                      child: Text("Registrar Tienda"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:10, left: 15, bottom: 5),
                  child: Center(
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(minimumSize: Size(145, 50)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Modificartienda()));
                      },
                      child: Text("Modificar Tienda"),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(500, 50)),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Shop()));
                  },
                  child: Text("Listado de tiendas"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
