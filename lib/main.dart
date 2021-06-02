import 'package:flutter/material.dart';

import 'package:flutter_furniture_shop/ui/cart_screen/cart_screen.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_screen.dart';
import 'package:flutter_furniture_shop/ui/product_detail_screen/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Shop',
      theme: ThemeData(
        primaryColor: const Color(0xff6376E9),
        backgroundColor: Color(0xfff5f5f5),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: const Color(0xff181B32),
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.75,
          ),
          bodyText1: TextStyle(
            color: Color(0xff181B32),
            letterSpacing: 0.75,
          ),
          // ToDo: extract TestStyle-s
        ),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: const Color(0xff181B32),
          ),
        ),
        fontFamily: 'Poppins',
      ),
      home: CatalogueScreen(),
      routes: {
        CatalogueScreen.routeName: (ctx) => CatalogueScreen(),
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        CartScreen.routeName: (ctx) => CartScreen(),
      },
    );
  }
}
