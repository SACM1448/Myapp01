import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp01/Carrito/ShoppingCart.dart';

import 'Tiendas/GestionTiendas.dart';
import 'Usuarios/GestionUsuario.dart';
import 'buscar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  HomeStart createState() => HomeStart();
}

@override
class HomeStart extends State<Home> {
  TextEditingController busqueda = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenidos',
      home: Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(title: Text('Domicilio App'), actions: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ShoppingCart()));
            },
            tooltip: 'Carrito de compras',
            child: const Icon(Icons.shopping_cart),
            backgroundColor: Colors.orange,
          )
        ]),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    child: Image.asset('image/logo2.png'),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset('image/logo.png'),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
                child: TextField(
                  controller: busqueda,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Búsqueda',
                      hintText: 'Tienda a Búscar'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(30, 50), shadowColor: Colors.amber),
                  onPressed: () {
                    print("presionado");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => buscar(busqueda.text)));
                  },
                  child: Text('Buscar'),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 60, right: 20, bottom: 5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => GestionUsuario()));
                      },
                      tooltip: 'Gestión Usuario',
                      color: Colors.white,
                      splashColor: Colors.blue,
                      icon: const Icon(
                        Icons.account_box,
                        size: 70,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 60, right: 20, bottom: 5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => GestionTiendas()));
                      },
                      tooltip: 'Gestionar tienda',
                      color: Colors.white,
                      splashColor: Colors.blue,
                      icon: const Icon(
                        Icons.home_work,
                        size: 70,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
