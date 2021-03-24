import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_order_challenge/page/ingredient.dart';
import 'package:pizza_order_challenge/page/pizza_order_bloc.dart';
import 'package:pizza_order_challenge/page/pizza_order_provider.dart';
import 'package:pizza_order_challenge/page/pizza_size_button.dart';
import 'package:pizza_order_challenge/page/pizza_size_state.dart';
import 'package:pizza_order_challenge/page/pizza_size_value.dart';

class PizzaDetails extends StatefulWidget {
  @override
  PizzaDetailsState createState() => PizzaDetailsState();
}

class PizzaDetailsState extends State<PizzaDetails> with TickerProviderStateMixin {
  
  AnimationController _animationController;
  AnimationController _animationRotationController;
  List<Animation> _animationList = <Animation>[];
  BoxConstraints _pizzaConstraints;
  final keyPizza = GlobalKey();

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
    WidgetsBinding.instance.addPostFrameCallback((_){
      final bloc = PizzaOrderProvider.of(context);
      bloc.notifierPizzaBoxAnimation.addListener(() {
        if(bloc.notifierPizzaBoxAnimation.value){
          _addPizzaToCart();
        }
      });
    });
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
              bloc.notifierFocused.value = true;
              return !bloc.containsIngredients(ingredient);
            },
            onAccept: (ingredient){
              print('accept');
              bloc.notifierFocused.value = false;
              setState(() {
                bloc.addIngredient(ingredient);
              });
              _buildIngredientsAnimation();
              _animationController.forward(from: 0.0);
            },
            onLeave: (ingredient){
              print('onLeave');
              bloc.notifierFocused.value = false;
            },
            builder: (context, list, rejects){
              return LayoutBuilder(
                builder: (context, constraints){
                  _pizzaConstraints = constraints;
                  return ValueListenableBuilder<PizzaMetadata>(
                    valueListenable: bloc.notifierImagePizza,
                    builder: (context, data, child){
                      if(data != null){
                        Future.microtask(() => _startPizzaBoxAnimation(data));
                      }
                      return AnimatedOpacity(
                        opacity: data != null ? 0.0 : 1.0, 
                        duration: const Duration(milliseconds: 60),
                        child: ValueListenableBuilder<PizzaSizeState>(
                        valueListenable: bloc.notifierPizzaSize,
                        builder: (context, pizzaSize, _){
                          return RepaintBoundary(
                            key: keyPizza,
                            child: RotationTransition(
                              turns: CurvedAnimation(
                                curve: Curves.elasticOut, 
                                parent: _animationRotationController,
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: ValueListenableBuilder<bool>(
                                      valueListenable: bloc.notifierFocused,
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
                            ),
                          );
                        },
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
          valueListenable: bloc.notifierPizzaSize,
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
    final bloc = PizzaOrderProvider.of(context);
    bloc.notifierPizzaSize.value = PizzaSizeState(value);
    _animationRotationController.forward(from: 0.0);
  }

  void _addPizzaToCart() {
    final bloc = PizzaOrderProvider.of(context);
    RenderRepaintBoundary boundary = keyPizza.currentContext.findRenderObject();
    bloc.transformToImage(boundary);
  }

  OverlayEntry _overlayEntry;

  void _startPizzaBoxAnimation(PizzaMetadata metadata){
    final bloc = PizzaOrderProvider.of(context);
    if (_overlayEntry == null){
      _overlayEntry = OverlayEntry(builder: (context){
        return PizzaOrderAnimation(
          metadata: metadata,
          onComplete: (){
            _overlayEntry.remove();
            _overlayEntry = null;
            bloc.reset();
          }
        );
      });
      Overlay.of(context).insert(_overlayEntry);
    }
  }
}


class PizzaOrderAnimation extends StatefulWidget {
  PizzaOrderAnimation({Key key, this.metadata, this.onComplete}) : super(key: key);

  final PizzaMetadata metadata;
  final VoidCallback onComplete;

  @override
  _PizzaOrderAnimationState createState() => _PizzaOrderAnimationState();
}

class _PizzaOrderAnimationState extends State<PizzaOrderAnimation> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _pizzaScaleAnimation;
  Animation<double> _pizzaOpacityAnimation;
  Animation<double> _boxEnterScaleAnimation;
  Animation<double> _boxExitScaleAnimation;
  Animation<double> _boxExitToCartAnimation;

  @override
  void initState() { 
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));
    _pizzaScaleAnimation = Tween(
      begin: 1.0, end: 0.5).animate(
        CurvedAnimation(
          parent: _controller, 
          curve: Interval(0.0, 0.2)
        )
    );
    _pizzaOpacityAnimation = CurvedAnimation(curve: Interval(0.2, 0.4), parent: _controller);
    _boxEnterScaleAnimation = CurvedAnimation(curve: Interval(0.0, 0.2), parent: _controller);
    _boxExitScaleAnimation = Tween(
      begin: 1.0, end:1.5).animate(
        CurvedAnimation(
          curve: Interval(0.5, 0.7), 
          parent: _controller
        )
    );
    _boxExitToCartAnimation = CurvedAnimation(parent: _controller, curve: Interval(0.8, 1.0));
    _controller.forward(from: 0.0);
    _controller.addStatusListener((status){
      if (status == AnimationStatus.completed){
        widget.onComplete();
      }
    } );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final metadata = widget.metadata;
    return Positioned(
      top: metadata.position.dy,
      left: metadata.position.dx,
      width: metadata.size.width,
      height: metadata.size.height,
      child: GestureDetector(
        onTap: (){
          widget.onComplete();
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            final moveToX = _boxExitToCartAnimation.value > 0 
              ? metadata.position.dx + metadata.size.width/2 * _boxExitToCartAnimation.value 
              : 0.0;
            final moveToY = _boxExitToCartAnimation.value > 0
              ? -metadata.size.height/2 * _boxExitToCartAnimation.value
              : 0.0;
            return Opacity(
              opacity: 1 - _boxExitToCartAnimation.value,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..translate(moveToX, moveToY)
                  ..rotateZ(_boxExitToCartAnimation.value)
                  ..scale(_boxExitScaleAnimation.value - 0.3),
                child: Transform.scale(
                  alignment: Alignment.center,
                  scale: 1 - _boxExitToCartAnimation.value,
                  child: Stack(
                    children: [  
                      _buildBox(),           
                      Opacity(
                        opacity: 1 - _pizzaOpacityAnimation.value,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                          ..scale(_pizzaScaleAnimation.value)..translate(0.0, 50 * (1-_pizzaOpacityAnimation.value)),
                        child: Image.memory(widget.metadata.imageBytes)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildBox(){
    return LayoutBuilder(builder: (context, constraints){
      final boxHeight = constraints.maxHeight / 2.0;
      final boxWidth = constraints.maxWidth / 2.0;
      final minAngle = -45.0;
      final maxAngle = -145.0;
      final boxClosingValue = lerpDouble(maxAngle, minAngle, _pizzaOpacityAnimation.value);
      return Opacity(
        opacity: _boxEnterScaleAnimation.value,
        child: Transform.scale(
          scale: _boxEnterScaleAnimation.value,
          child: Stack(
            children: [
              Center(
                child: Transform(
                  alignment: Alignment.topCenter,
                  transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateX(degreesToRads(minAngle)),
                  child: Image.asset(
                    'assets/pizza_order/box_inside.png',
                    height: boxHeight,
                    width: boxWidth,
                  ),
                ),
              ),
              Center(
                child: Transform(
                  alignment: Alignment.topCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateX(degreesToRads(boxClosingValue)),
                  child: Image.asset(
                    'assets/pizza_order/box_inside.png',
                    height: boxHeight,
                    width: boxWidth,
                  ),
                ),
              ),
              if (boxClosingValue >= -80)
              Center(
                child: Transform(
                  alignment: Alignment.topCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateX(degreesToRads(boxClosingValue)),
                  child: Image.asset(
                    'assets/pizza_order/box_diegoveloper.png',
                    height: boxHeight,
                    width: boxWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }
}

num degreesToRads(num deg){
  return (deg * pi) / 180.0;
}