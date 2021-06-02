import 'package:flutter/material.dart';

import 'package:flutter_furniture_shop/ui/common/bottom_navigation_bar.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_item_card.dart';
import 'package:flutter_furniture_shop/ui/common/styles.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Корзина',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              CartItemCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 56,
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          label: Text(
            'Перейти к оформлению заказа',
            style: fabText,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomBottomNavigationBar(2),
    );
  }
}
