import 'package:flutter/material.dart';
import 'package:pizza_order_challenge/page/main_pizza_order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Order | Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'RobotoMono',
      ),
      home: MainPizzaOrderApp(),
    );
  }
}
