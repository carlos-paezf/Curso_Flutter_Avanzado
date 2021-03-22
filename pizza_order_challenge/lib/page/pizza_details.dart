import 'package:flutter/material.dart';
import 'package:pizza_order_challenge/page/ingredient.dart';
import 'package:pizza_order_challenge/page/pizza_order_provider.dart';
import 'package:pizza_order_challenge/page/pizza_size_button.dart';
import 'package:pizza_order_challenge/page/pizza_size_state.dart';
import 'package:pizza_order_challenge/page/pizza_size_value.dart';

class PizzaDetails extends StatefulWidget {
  @override
  PizzaDetailsState createState() => PizzaDetailsState();
}

class PizzaDetailsState extends State<PizzaDetails> with TickerProviderStateMixin {
  
  final _notifierFocused = ValueNotifier(false);
  AnimationController _animationController;
  AnimationController _animationRotationController;
  List<Animation> _animationList = <Animation>[];
  BoxConstraints _pizzaConstraints;
  final _notifierPizzaSize = ValueNotifier<PizzaSizeState>(PizzaSizeState(PizzaSizeValue.m));

  void _buildIngredientsAnimation() {
    _animationList.clear();
    _animationList.add(CurvedAnimation(
      curve: Interval(0.0 , 0.8, curve: Curves.decelerate),
      parent: _animationController,
    ));
    _animationList.add(CurvedAnimation(
      curve: Interval(0.2 , 0.8, curve: Curves.decelerate),
      parent: _animationController,
    ));
    _animationList.add(CurvedAnimation(
      curve: Interval(0.4 , 1.0, curve: Curves.decelerate),
      parent: _animationController,
    ));
    _animationList.add(CurvedAnimation(
      curve: Interval(0.1 , 0.7, curve: Curves.decelerate),
      parent: _animationController,
    ));
    _animationList.add(CurvedAnimation(
      curve: Interval(0.3 , 1.0, curve: Curves.decelerate),
      parent: _animationController,
    ));
  }

  Widget _buildIngredientsWidget(Ingredient deletedIngredient) {
    List<Widget> elements = [];
    final listIngredients = List.from(PizzaOrderProvider.of(context).listIngredients);
    if (deletedIngredient != null){
      listIngredients.add(deletedIngredient);
    }
    if (_animationList.isNotEmpty) {
      for(int i = 0; i < listIngredients.length; i++) {
        Ingredient ingredient = listIngredients[i];
        final ingredientWidget = Image.asset(
                    ingredient.imageUnit, 
                    height: 40,
                  );
        for(int j = 0; j < ingredient.positions.length; j++) {
          final animation = _animationList[j];
          final position = ingredient.positions[j];
          final positionX = position.dx;
          final positionY = position.dy;
          double fromX = 0.0, fromY = 0.0;
          if(i == listIngredients.length - 1 && _animationController.isAnimating) {
            if (j < 1){
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -_pizzaConstraints.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
            }
            final opacity = animation.value;
            if (animation.value > 0) {
              elements.add(
                Opacity(
                  opacity: opacity,
                  child: Transform(
                    transform: Matrix4.identity()..translate(
                      fromX + _pizzaConstraints.maxWidth * positionX,
                      fromY + _pizzaConstraints.maxHeight * positionY,
                    ),
                    child: ingredientWidget,
                  ),
                )
              );
            }
          } else {
            elements.add(
                Transform(
                  transform: Matrix4.identity()..translate(
                    _pizzaConstraints.maxWidth * positionX,
                    _pizzaConstraints.maxHeight * positionY,
                  ),
                  child: ingredientWidget,
                )
              );
          }
        }
      }
      return Stack(
        children: elements,
      );
    }
    return SizedBox.fromSize();
  }

  @override
  void initState() { 
    super.initState();
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 500),
    );
    _animationRotationController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
    void dispose() {
      super.dispose();
      _animationController.dispose();
      _animationRotationController.dispose();
    }

  @override
  Widget build(BuildContext context) {
    final bloc = PizzaOrderProvider.of(context);
    return Column(
      children: [
        Expanded(
          child: DragTarget<Ingredient>(
            onWillAccept: (ingredient){
              print('onWillAccept');
              _notifierFocused.value = true;
              return !bloc.containsIngredients(ingredient);
            },
            onAccept: (ingredient){
              print('accept');
              _notifierFocused.value = false;
              setState(() {
                bloc.addIngredient(ingredient);
              });
              _buildIngredientsAnimation();
              _animationController.forward(from: 0.0);
            },
            onLeave: (ingredient){
              print('onLeave');
              _notifierFocused.value = false;
            },
            builder: (context, list, rejects){
              return LayoutBuilder(
                builder: (context, constraints){
                  _pizzaConstraints = constraints;
                  return ValueListenableBuilder<PizzaSizeState>(
                    valueListenable: _notifierPizzaSize,
                    builder: (context, pizzaSize, _){
                      return RotationTransition(
                        turns: CurvedAnimation(
                          curve: Curves.elasticOut, 
                          parent: _animationRotationController,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: ValueListenableBuilder<bool>(
                                valueListenable: _notifierFocused,
                                builder: (context, focused, _){
                                  return AnimatedContainer(
                                    height: focused ? 
                                      constraints.maxHeight * pizzaSize.factor - 10 : 
                                      constraints.maxHeight * pizzaSize.factor - 50,
                                    duration: const Duration(milliseconds: 300),
                                    child: Stack(
                                      children: [
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 10.0,
                                                color: Colors.grey[350],
                                                offset: Offset(0.0 , 5.0),
                                                spreadRadius: 5.0,
                                              ),
                                            ]
                                          ),
                                          child: Image.asset('assets/pizza_order/dish.png')
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(13.0), 
                                          child: Image.asset('assets/pizza_order/pizza-1.png'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            ValueListenableBuilder<Ingredient>(
                              valueListenable: bloc.notifierDeletedIngredient,
                              builder: (context, deletedIngredient, _){
                                _animatedDeletedIngredient(deletedIngredient);
                                return AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, _) {
                                    return _buildIngredientsWidget(deletedIngredient);
                                  },
                                );
                              }
                            ),
                          ]
                        ),
                      );
                    },
                  );
                },
              );
            }  
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ValueListenableBuilder<int>(
          valueListenable: bloc.notifierTotal,
          builder: (context, totalValue, _) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation){
                return FadeTransition(
                  opacity: animation, 
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: Offset(0.0, 0.0), 
                        end: Offset(0.0, animation.value),
                      ),
                    ), 
                    child: child
                  ), 
                );
              },
              child: Text(
                '\$$totalValue',
                key: UniqueKey(),
                style: TextStyle(
                  color: Colors.brown, 
                  fontSize: 34, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        ),
        const SizedBox(
          height: 15,
        ),
        ValueListenableBuilder<PizzaSizeState>(
          valueListenable: _notifierPizzaSize,
          builder: (context, pizzaSize, _){
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PizzaSizeButton(
                  text: 'S', 
                  onTap: (){
                    _updatePizzaSize(PizzaSizeValue.s);
                  }, 
                  selected: pizzaSize.value == PizzaSizeValue.s,
                ),
                PizzaSizeButton(
                  text: 'M', 
                  onTap: (){
                    _updatePizzaSize(PizzaSizeValue.m);
                  }, 
                  selected: pizzaSize.value == PizzaSizeValue.m,
                ),
                PizzaSizeButton(
                  text: 'L', 
                  onTap: (){
                    _updatePizzaSize(PizzaSizeValue.l);
                  }, 
                  selected: pizzaSize.value == PizzaSizeValue.l,
                )
              ],
            );
          },
        ),
      ],
    );
  }

  void _animatedDeletedIngredient(Ingredient deletedIngredient) async{
    if (deletedIngredient != null) {
      await _animationController.reverse(from: 1.0);
      final bloc = PizzaOrderProvider.of(context);
      bloc.refreshDeletedIngredient();
    }
  }

  void _updatePizzaSize(PizzaSizeValue value){
    _notifierPizzaSize.value = PizzaSizeState(value);
    _animationRotationController.forward(from: 0.0);
  }
}
