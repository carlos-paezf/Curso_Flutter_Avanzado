import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({Key key, this.imageSize = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //! Aplicacion de mi clase Responsive
    final Responsive responsive = Responsive.of(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 27, color: Colors.black38, offset: Offset(0, 15)),
          ], shape: BoxShape.circle),
          //? Definir que la imagen siempre sea redondeada
          child: ClipOval(
            child: Center(
              //? Especificar el archivo que servira de base
              child: Image.asset(
                'assets/2.png',
                width: this.imageSize,
                height: this.imageSize,
              ),
            ),
          ),
        ),
        //! Boton de estilo IOS
        Positioned(
          bottom: responsive.isTablet ? responsive.dp(0.5) : 0,
          right: responsive.isTablet ? responsive.dp(1) : 0,
          child: CupertinoButton(
            child: Container(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size:
                    responsive.isTablet ? responsive.dp(2) : responsive.dp(2.5),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              padding: EdgeInsets.all(3),
            ),
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(50),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
