import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import '../widgets/circle.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //! Aplicacion de mi clase Responsive
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: Container(
        //* Ocupar todo el espacio posible
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        //* Ubicación de los widgets
        child: Stack(alignment: Alignment.center, children: <Widget>[
          //* Ubicar el widget con valores especificos
          //? Widget Circle de la derecha
          Positioned(
            child: Circle(
              size: responsive.wp(90),
              colors: [
                Colors.pink,
                Colors.pinkAccent,
                Colors.pink[500],
                Colors.pinkAccent[400],
                Colors.red[700]
              ],
            ),
            right: responsive.wp(-20),
            top: responsive.wp(-30),
          ),
          //? Widget Circle de la izquierda superpuesto al anterior
          Positioned(
            child: Circle(
              size: responsive.wp(65),
              colors: [
                Colors.orange,
                Colors.deepOrangeAccent,
                Colors.deepOrange[700]
              ],
            ),
            left: responsive.wp(-15),
            top: responsive.wp(-30),
          ),

          //? Widget para el icono de login
          Positioned(
            top: responsive.wp(40),
            child: Column(
              children: <Widget>[
                IconContainer(size: responsive.wp(30)),
                SizedBox(height: responsive.hp(3)),
                Text(
                  'Hello Again\nWelcome Back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: responsive.dp(2.5)),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
