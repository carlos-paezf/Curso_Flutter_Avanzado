import 'package:pizza_order_challenge/page/pizza_size_value.dart';

class PizzaSizeState {
  final PizzaSizeValue value;
  final double factor;

  PizzaSizeState(this.value) : factor = _getFactorSize(value);

  static double _getFactorSize(PizzaSizeValue value) {
    switch (value) {
      case PizzaSizeValue.s:
        return 0.75;
      case PizzaSizeValue.m:
        return 0.9;
      case PizzaSizeValue.l:
        return 1.2;
    }
    return 0.0;
  }
}
