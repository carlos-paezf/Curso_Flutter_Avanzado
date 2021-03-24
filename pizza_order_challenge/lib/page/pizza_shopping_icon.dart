import 'package:flutter/material.dart';
import 'package:pizza_order_challenge/page/pizza_order_provider.dart';

class PizzaShoppingIcon extends StatefulWidget {
  PizzaShoppingIcon({Key key}) : super(key: key);

  @override
  _PizzaShoppingIconState createState() => _PizzaShoppingIconState();
}

class _PizzaShoppingIconState extends State<PizzaShoppingIcon> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _animationScaleOut;
  Animation<double> _animationScaleIn;
  int counter = 0;

  @override
  void initState() { 
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600));
    _animationScaleOut = CurvedAnimation(
      curve: Interval(0.0, 0.5),
      parent: _controller,
    );
    _animationScaleIn = CurvedAnimation(
      parent: _controller, 
      curve: Interval(0.5, 1.0),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      final bloc = PizzaOrderProvider.of(context);
      bloc.notifierCartIconAnimation.addListener(() {
        counter = bloc.notifierCartIconAnimation.value;
        _controller.forward(from: 0.0);
      });
    });
  }
  
  @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, snapshot){
        double scale;
        const scaleFactor = 0.5;
        if (_animationScaleOut.value < 1.0){
          scale = 1.0 + scaleFactor * _animationScaleOut.value;
        } else if (_animationScaleIn.value <= 1.0) {
          scale = (1.0 + scaleFactor) - scaleFactor * _animationScaleIn.value;
        }
        return Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.brown,
                ),
                onPressed: () {},
              ),
              Positioned(
                top: 5,
                right: 10,
                child: Transform.scale(
                  scale: _animationScaleOut.value,
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.red,
                    child: Text(
                      counter.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

