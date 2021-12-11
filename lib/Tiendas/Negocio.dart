import 'package:flutter/material.dart';

class Negocio extends StatefulWidget {
  @override
  NegocioApp createState() => NegocioApp();
}

class NegocioApp extends State<Negocio> {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Tienda de Hamburguesas',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'MCDonalds',
                  style: TextStyle(
                    color: Colors.red[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.amber[500],
          ),
          Text('4,9'),
        ],
      ),
    );
    Color color = Theme.of(context).primaryColorDark;

    Widget buttonSection = Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'Llamar'),
          _buildButtonColumn(color, Icons.near_me, 'Dirección'),
          _buildButtonColumn(color, Icons.share, 'Compartir'),
        ],
      ),
    );
    Widget textSection = Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      child: Text(
        'McDonalds es una franquicia de restaurantes de comida rápida estadounidense con sede en Chicago,'
        ' Illinois. Sus principales productos son las hamburguesas, las patatas fritas, los menús para '
        'el desayuno y los refrescos.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        softWrap: true,
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border(
          top: BorderSide(width: 10.0, color: Colors.cyan),
          bottom: BorderSide(width: 10.0, color: Colors.cyan),
          right: BorderSide(width: 10.0, color: Colors.blue),
          left: BorderSide(width: 10.0, color: Colors.blue),
        ),
      ),
    );
    return MaterialApp(
      title: 'Tienda McDonalds',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Negocio McDonalds'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'image/McDonalds-logo.png',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
