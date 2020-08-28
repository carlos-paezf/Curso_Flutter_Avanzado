import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'input_text.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {

    //! Atributo para aplicar Responsive
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Column(
        children: <Widget>[
          InputText(
            label: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            fontSize: responsive.dp(1.55),
          ),
          Container(
            //? Borde inferior
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
            child: Row(
              children: <Widget>[
                //? Expandirse en el espacio disponible
                Expanded(
                  child: InputText(
                    label: 'Password',
                    obscureText: true,
                    borderEnable: false,
                    fontSize: responsive.dp(1.55),
                  ),
                ),
                //? Boton acompañante
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          //? Separador entre el formulario y el boton ingresar
          SizedBox(
            height: responsive.dp(5),
          ),
          //? Contenedor del boton ingresar
          SizedBox(
            width: double.infinity,
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Sign in',
                style: TextStyle(color: Colors.white, fontSize: responsive.dp(1.7)),
              ),
              onPressed: () {},
              color: Colors.red,
            ),
          ),
          //? Separador entre el boton y acciones adicionales
          SizedBox(
            height: responsive.dp(3),
          ),
          //? Acciones adicionales
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('New to Friendly Desig?', style: TextStyle(fontSize: responsive.dp(1.55)),),
              FlatButton(
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.redAccent, fontSize: responsive.dp(1.55)),
                ),
                onPressed: () {},
              )
            ],
          ),
          //? Separacion entre acciones addicionales y borde inferior
          SizedBox(
            height: responsive.dp(6),
          ),
        ],
      ),
    );
  }
}
