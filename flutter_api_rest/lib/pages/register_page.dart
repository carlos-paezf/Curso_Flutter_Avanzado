import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/avatar_button.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/circle.dart';

class RegisterPage extends StatefulWidget {
  //! Propiedad para la ruta
  static const routeName = 'register';

  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    //! Aplicacion de mi clase Responsive
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      //! Widget para reaccionar segun nuestros gestos
      body: GestureDetector(
        onTap: () {
          //? Desefocar cada vez que tocamos en espacios "sin funcionalidad"
          FocusScope.of(context).unfocus();
        },

        //! Dentro de este widget, solo los elementos que tenga almacenados, podran ser scrollables
        child: SingleChildScrollView(
          child: Container(
            //* Ocupar todo el espacio posible
            width: double.infinity,
            //? Sin importar la cantidad de widgets que tenga, no se sobrepondran a los otros
            height: responsive.height,
            color: Colors.white,
            //* Ubicación de los widgets
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                //* Ubicar el widget con valores especificos
                //? Widget Circle de la derecha
                Positioned(
                  child: Circle(
                    size: responsive.wp(90),
                    colors: [
                      Colors.pink[50],
                      Colors.pink[100],
                      Colors.pink[200],
                      Colors.pink[300],
                      Colors.pinkAccent,
                      Colors.pink[400],
                      Colors.pink[500],
                      Colors.pink[600],
                      Colors.pinkAccent[700],
                      Colors.pink[700],
                      Colors.pink[800],
                      Colors.pink[900],
                    ],
                  ),
                  right: responsive.isTablet
                      ? responsive.wp(-30)
                      : responsive.wp(-20),
                  top: responsive.isTablet
                      ? responsive.wp(-35)
                      : responsive.wp(-20),
                ),

                //? Widget Circle de la izquierda superpuesto al anterior
                Positioned(
                  child: Circle(
                    size: responsive.wp(65),
                    colors: [
                      Colors.orange[50],
                      Colors.orange[100],
                      Colors.orange[200],
                      Colors.orange[300],
                      Colors.orange[400],
                      Colors.orange,
                      Colors.orange[600],
                      Colors.orange[700],
                      Colors.orange[800],
                      Colors.orange[900],
                      Colors.deepOrange[700],
                      Colors.deepOrange[800],
                      Colors.deepOrange[900]
                    ],
                  ),
                  left: responsive.isTablet
                      ? responsive.wp(-10)
                      : responsive.wp(-15),
                  top: responsive.isTablet
                      ? responsive.wp(-25)
                      : responsive.wp(-20),
                ),
                //? Widget para el icono de login
                Positioned(
                  top: responsive.isTablet
                      ? responsive.wp(15)
                      : responsive.wp(22),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Hello!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: responsive.dp(2.5), color: Colors.white),
                      ),
                      SizedBox(height: responsive.dp(1)),
                      Text(
                        'Sign up to get start!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: responsive.dp(2.5), color: Colors.white),
                      ),
                      SizedBox(height: responsive.dp(3)),
                      AvatarButton(
                        imageSize: responsive.wp(25),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: responsive.wp(5),
                  top: responsive.hp(3),
                  //! Boton de estilo IOS
                  child: SafeArea(
                    child: CupertinoButton(
                      child: Icon(Icons.arrow_back),
                      color: Colors.black38,
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
