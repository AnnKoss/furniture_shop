import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_bloc.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_screen.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_screen.dart';
import 'package:flutter_furniture_shop/ui/product_detail_screen/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          // ToDo: add error handling
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return FurnitureShopApp();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class FurnitureShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<FurnitureItemsRepository>(
      create: (ctx) => FurnitureItemsRepository(
        ItemsStorage(),
      ),
      child: BlocProvider<FurnitureItemsBloc>(
        create: (BuildContext context) {
          FurnitureItemsBloc _bloc = FurnitureItemsBloc(
            FurnitureItemsLoadingState(),
            context.read<FurnitureItemsRepository>(),
          );
          return _bloc;
        },
        child: MaterialApp(
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
        ),
      ),
    );
  }
}
