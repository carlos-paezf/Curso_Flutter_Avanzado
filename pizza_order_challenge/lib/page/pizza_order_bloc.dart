import 'package:flutter/foundation.dart' show ChangeNotifier, ValueNotifier;
import 'package:pizza_order_challenge/page/ingredient.dart';

//? BLoC = Bussines Logic Components
class PizzaOrderBLoC extends ChangeNotifier{
  final listIngredients = <Ingredient>[];
  final notifierTotal = ValueNotifier(15);
  final notifierDeletedIngredient = ValueNotifier<Ingredient>(null);

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
}