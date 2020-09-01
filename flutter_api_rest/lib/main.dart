import 'package:flutter/material.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    //! Rotacion del telefono permitida
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        //? Como no hago uso del parametro BuildContext, introduzco el _
        LoginPage.routeName: (_)=> LoginPage(),
        RegisterPage.routeName: (_)=> RegisterPage()
      },
    );
  }
}
