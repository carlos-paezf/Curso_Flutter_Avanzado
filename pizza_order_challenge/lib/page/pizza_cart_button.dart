import 'package:flutter/material.dart';

class PizzaCartButton extends StatefulWidget {
  const PizzaCartButton({Key key, this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  PizzaCartButtonState createState() => PizzaCartButtonState();
}

class PizzaCartButtonState extends State<PizzaCartButton> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, 
      lowerBound: 1.0,
      upperBound: 1.5,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  Future<void> _animatedButton() async {
    await _animationController.forward(from: 0.0);
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap();
        _animatedButton();
      },
      child: AnimatedBuilder(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.withOpacity(0.5),
                Colors.orange,
              ]
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[350],
                blurRadius: 5.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 2.0,
              ),
            ]
          ),
          child: Icon(
            Icons.add_shopping_cart_outlined,
            color: Colors.white,
            size: 35,
          ),
        ),
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 2 - _animationController.value,
            child: child, 
          );
        },
      ),
    );
  }
}
