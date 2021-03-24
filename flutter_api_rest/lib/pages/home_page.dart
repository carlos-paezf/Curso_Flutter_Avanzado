import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/my_api.dart';
import 'package:flutter_api_rest/models/user.dart';
import 'package:flutter_api_rest/utils/auth.dart';
import 'package:flutter_api_rest/widgets/avatar_button.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
  User user;

  @override
  void afterFirstLayout(BuildContext context) {
    this._init();
  }

  _init() async {
    this.user = await MyAPI.instance.getUserInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              this.user == null
              //? Mientras espera, mostrar un circulo de carga
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
              //? Traer los elementos o atributos del usuario
                  : Column(
                      children: <Widget>[
                        AvatarButton(imageSize: 100,),
                        Text(this.user.username),
                        Text(this.user.email),
                        Text(this.user.createdAt.toIso8601String()),
                        Text(this.user.createdAt.toString())
                      ],
                    ),
              FlatButton(
                onPressed: () => Auth.instance.logOut(context),
                child: Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
