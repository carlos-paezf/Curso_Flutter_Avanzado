import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/my_api.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'input_text.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  //! Propiedad
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';
  //! Metodo de prueba para el boton Sign in
  _submit() async {
    final isOk = _formKey.currentState.validate();
    print("form isOk $isOk");
    if (isOk) {
      //* Si los datos son correctos, se empieza a consumir la API
      MyAPI myAPI = new MyAPI();
      //* Esperar que se realice la llamada al API
      await myAPI.register(
        context,
        username: _username,
        email: _email,
        password: _password,
      );
      //progressDialog.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    //! Atributo para aplicar Responsive
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? responsive.wp(75) : responsive.wp(80),
          minWidth: responsive.isTablet ? responsive.wp(70) : responsive.wp(75),
        ),
        child: Form(
          //! key necesaria para poder acceder a los metodos de Form
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                label: 'UserName:',
                keyboardType: TextInputType.emailAddress,
                fontSize: responsive.dp(1.55),
                onChaged: (text) {
                  _username = text;
                },
                //! Validacion del campo de texto
                validator: (text) {
                  if (text.trim().length < 5) {
                    return "Invalid username";
                  }
                  return null;
                },
              ),
              SizedBox(
                height:
                    responsive.isTablet ? responsive.dp(1) : responsive.dp(3),
              ),
              InputText(
                label: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                fontSize: responsive.dp(1.55),
                onChaged: (text) {
                  _email = text;
                },
                //! Validacion del campo de texto
                validator: (text) {
                  if (!text.contains("@")) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height:
                    responsive.isTablet ? responsive.dp(1) : responsive.dp(3),
              ),
              InputText(
                label: 'Password',
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                fontSize: responsive.dp(1.55),
                onChaged: (text) {
                  _password = text;
                },
                //! Validacion del campo de texto
                validator: (text) {
                  if (text.trim().length < 8) {
                    return "Invalid password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height:
                    responsive.isTablet ? responsive.dp(1) : responsive.dp(3),
              ),
              //? Separador entre el formulario y el boton ingresar
              SizedBox(
                height:
                    responsive.isTablet ? responsive.dp(3) : responsive.dp(5),
              ),
              //? Contenedor del boton ingresar
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white, fontSize: responsive.dp(1.7)),
                  ),
                  onPressed: this._submit,
                  color: Colors.red,
                ),
              ),
              //? Separador entre el boton y acciones adicionales
              SizedBox(
                height:
                    responsive.isTablet ? responsive.dp(1.5) : responsive.dp(3),
              ),
              //? Acciones adicionales
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: responsive.dp(1.55)),
                  ),
                  FlatButton(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: responsive.dp(1.55)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              //? Separacion entre acciones addicionales y borde inferior
              SizedBox(
                height:
                    responsive.isTablet ? responsive.dp(4) : responsive.dp(6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
