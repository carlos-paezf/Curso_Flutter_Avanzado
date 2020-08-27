import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  //! Atributos
  final double size;
  final List<Color> colors;

  //! Constructor
  //? El atributo size, sera obligatorio
  //? El atributo colors, sera obligatio
  Circle({Key key, @required this.size, @required this.colors})
      //* Hay una validacion para crear el widget, size debe ser diferente a un null y mayor a 0
      : assert(size != null && size > 0),
        //* La segunda validacion es que colors no sea null y que por lo menos tenga 2 colores
        assert(colors != null && colors.length > 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
          //* Dar la forma de circulo
          shape: BoxShape.circle,
          //* Colores que conformaran el widget
          gradient: LinearGradient(
            colors: this.colors,
            //? Direccion del gradiente
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )),
    );
  }
}
