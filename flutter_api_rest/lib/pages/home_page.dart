import 'package:flutter/material.dart';
import '../widgets/circle.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    //! Dimensiones del dispositivo que se esta usando, esto permite un widget responsive
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        //* Ocupar todo el espacio posible
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        //* Ubicación del widget Circle
        child: Stack(children: <Widget>[
          //* Ubicar el widget con valores especificos
          //? Widget Circle de la derecha
          Positioned(
            child: Circle(
              size: size.width * 0.9,
              colors: [Colors.pink, Colors.pinkAccent, Colors.pink[500], Colors.pinkAccent[400], Colors.red[700]],
            ),
            right: size.width * -0.2,
            top: size.width * -0.3,
          ),
          //? Widget Circle de la izquierda superpuesto al anterior
          Positioned(
            child: Circle(
              size: size.width * 0.65,
              colors: [Colors.orange, Colors.deepOrangeAccent, Colors.deepOrange[700]],
            ),
            left: size.width * -0.15,
            top: size.width * -0.3,
          )
        ]),
      ),
    );
  }
}
