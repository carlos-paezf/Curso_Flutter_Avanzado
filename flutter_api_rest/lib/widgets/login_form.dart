import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'input_text.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //! Propiedad
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password='';
  //! Metodo de prueba para el boton Sign in
  _submit() {
    final isOk = _formKey.currentState.validate();
    print("form isOk $isOk");
    if (isOk){}
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
                        onChaged: (text) {
                          _password = text;
                        },
                        validator: (text){
                          //* If la constraseña esta vacia, es invalida, trim() elimina los espacios en blanco
                          if (text.trim().length==0){
                            return "Invalid password";
                          }
                          return null;
                        },
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
                height:
                    responsive.isTablet ? responsive.dp(3) : responsive.dp(5),
              ),
              //? Contenedor del boton ingresar
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Sign in',
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
                    'New to Friendly Desig?',
                    style: TextStyle(fontSize: responsive.dp(1.55)),
                  ),
                  FlatButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: responsive.dp(1.55)),
                    ),
                    onPressed: () {},
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
