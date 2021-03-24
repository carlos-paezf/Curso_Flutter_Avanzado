import 'package:flutter/material.dart';
import 'package:pizza_order_challenge/page/pizza_cart_button.dart';
import 'package:pizza_order_challenge/page/pizza_details.dart';
import 'package:pizza_order_challenge/page/pizza_ingredient_item.dart';
import 'package:pizza_order_challenge/page/pizza_order_bloc.dart';
import 'package:pizza_order_challenge/page/pizza_order_provider.dart';

const _pizzaCartSize = 55.0;

class PizzaOrderDetails extends StatefulWidget{
  @override
  _PizzaOrderDetailsState createState() => _PizzaOrderDetailsState();
}

class _PizzaOrderDetailsState extends State<PizzaOrderDetails> {
  final bloc = PizzaOrderBLoC();
  Widget build(BuildContext context){
    return PizzaOrderProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'New Orleans Pizza', 
            style: TextStyle(
              color: Colors.brown,
              fontSize: 28,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.brown,
              ),
              onPressed: (){},
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              top: 5,
              bottom: 35,
              left: 5,
              right: 5,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: PizzaDetails(),
                    ),
                    Expanded(
                      flex: 2,
                      child: PizzaIngredients(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              height: _pizzaCartSize,
              width: _pizzaCartSize,
              left: MediaQuery.of(context).size.width/2-_pizzaCartSize/2,
              child: PizzaCartButton(
                onTap: (){
                  bloc.startPizzaBoxAnimation();
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}