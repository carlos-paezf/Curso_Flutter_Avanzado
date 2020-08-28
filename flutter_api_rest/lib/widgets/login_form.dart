import 'package:flutter/material.dart';
import 'input_text.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Column(
        children: <Widget>[
          InputText(
            label: 'Email Address',
            keyboardType: TextInputType.emailAddress,
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
        ],
      ),
    );
  }
}
