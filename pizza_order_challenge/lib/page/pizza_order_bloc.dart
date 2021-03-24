import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart' show ChangeNotifier, ValueNotifier;
import 'package:flutter/rendering.dart';
import 'package:pizza_order_challenge/page/ingredient.dart';
import 'package:pizza_order_challenge/page/pizza_size_state.dart';
import 'package:pizza_order_challenge/page/pizza_size_value.dart';


class PizzaMetadata{
  final Uint8List imageBytes;
  final Offset position;
  final Size size;
  const PizzaMetadata(this.imageBytes, this.position, this.size);
}

const initialTotal = 15;
//? BLoC = Bussines Logic Components
class PizzaOrderBLoC extends ChangeNotifier{
  final listIngredients = <Ingredient>[];
  final notifierTotal = ValueNotifier(15);
  final notifierDeletedIngredient = ValueNotifier<Ingredient>(null);
  final notifierFocused = ValueNotifier(false);
  final notifierPizzaSize = ValueNotifier<PizzaSizeState>(PizzaSizeState(PizzaSizeValue.m));
  final notifierPizzaBoxAnimation = ValueNotifier(false);
  final notifierImagePizza = ValueNotifier<PizzaMetadata>(null);
  final notifierCartIconAnimation = ValueNotifier(0);

  void addIngredient(Ingredient ingredient) {
    listIngredients.add(ingredient);
    notifierTotal.value++;
  }

  void removeIngredient(Ingredient ingredient){
    listIngredients.remove(ingredient);
    notifierTotal.value--;
    notifierDeletedIngredient.value = ingredient;
  }

  void refreshDeletedIngredient(){
    notifierDeletedIngredient.value = null;
  }

  bool containsIngredients(Ingredient ingredient) {
    for (Ingredient i in listIngredients) {
      if (i.compare(ingredient)) {
        return true;
      }
    }
    return false;
  }

  void reset(){
    notifierPizzaBoxAnimation.value = false;
    notifierImagePizza.value = null;
    listIngredients.clear();
    notifierTotal.value = initialTotal;
    notifierCartIconAnimation.value++;
  }

  void startPizzaBoxAnimation(){
    notifierPizzaBoxAnimation.value = true;
  }

  Future<void> transformToImage(RenderRepaintBoundary boundary) async{
    final position = (boundary as RenderBox).localToGlobal(Offset.zero);
    final size = boundary.size;
    final image = await boundary.toImage();
    ByteData bytedata = await image.toByteData(format: ImageByteFormat.png);
    notifierImagePizza.value = PizzaMetadata(bytedata.buffer.asUint8List(), position, size);
  }
}