import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  //! Atributos
  final double size;

  //! Constructor
  //? El atributo size, sera obligatorio
  const IconContainer({Key key, @required this.size})
      : assert(size != null && size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size * 0.8,
      height: this.size * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          //* Bordes Circulares
          borderRadius: BorderRadius.circular(this.size * 0.2),
          boxShadow: [
            //* Sombra del icono
            BoxShadow(
              color: Colors.black45,
              //* Tamaño del sombreado
              blurRadius: 25,
              //* Ubicacion en el plano bidimensional respecto a la localizacion del icono
              offset: Offset(2, 10),
            ),
          ]),
      padding: EdgeInsets.all(this.size * 0.15),
      child: Center(
        //? Especificar el archivo para el login
        child: SvgPicture.asset(
          'assets/iniciar-sesion.svg',
          width: this.size * 0.5,
          height: this.size * 0.5,
        ),
      ),
    );
  }
}
