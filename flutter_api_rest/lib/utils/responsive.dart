import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class Responsive {
  //! Atributos de las medidas del dispositivo
  double _width, _height, _diagonal;
  bool _isTablet;

  //* metodos get para los atributos privados
  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;

  //? Funcion estatica para retornar una instancia de la clase responsive
  static Responsive of(BuildContext context) => Responsive(context);

  //! Constructor
  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    this._width = size.width;
    this._height = size.height;
    //* c^2 = a^2 + b^2  => c = sqrt(a^2 + b^2)
    this._diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    //* Saber si el dispositivo es una tablet o no
    this._isTablet = size.shortestSide >= 600;
  }

  //! Valor del anncho respecto a un porcentaje
  double wp(double percent) => _width * percent / 100;
  //! Valor del alto respecto a un porcentaje
  double hp(double percent) => _height * percent / 100;
  //! Valor de la diagonal respecto a un porcentaje
  double dp(double percent) => _diagonal * percent / 100;
}
