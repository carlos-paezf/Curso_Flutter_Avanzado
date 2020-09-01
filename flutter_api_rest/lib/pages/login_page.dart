import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_api_rest/widgets/login_form.dart';
import '../widgets/circle.dart';

class LoginPage extends StatefulWidget {
  //! Propiedad para la ruta
  static const routeName = 'login';
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      Colors.pink,
                      Colors.pinkAccent,
                      Colors.pink[500],
                      Colors.pinkAccent[400],
                      Colors.red[700]
                    ],
                  ),
                  right: responsive.isTablet
                      ? responsive.wp(-30)
                      : responsive.wp(-20),
                  top: responsive.isTablet
                      ? responsive.wp(-50)
                      : responsive.wp(-30),
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
                  left: responsive.isTablet
                      ? responsive.wp(-10)
                      : responsive.wp(-15),
                  top: responsive.isTablet
                      ? responsive.wp(-40)
                      : responsive.wp(-30),
                ),

                //? Widget para el icono de login
                Positioned(
                  top: responsive.isTablet
                      ? responsive.wp(15)
                      : responsive.wp(40),
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

                //? Widget para el formulario de Login
                LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
