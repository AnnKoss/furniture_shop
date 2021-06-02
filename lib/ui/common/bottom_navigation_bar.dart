import 'package:flutter/material.dart';

import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_screen.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int index;
  CustomBottomNavigationBar(
    this.index,
  );

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = widget.index;

    return Container(
      height: 75,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Catalogue',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Color(0xff181B32),
          backgroundColor: Color(0xffEFF0F6),
          showSelectedLabels: false, 
          showUnselectedLabels: false,
          iconSize: 32,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.of(context).pushNamed(CatalogueScreen.routeName);
                break;
              case 1:
                Navigator.of(context).pushNamed('/favourite');
                break;
              //not existing yet
              case 2:
                Navigator.of(context).pushNamed(CartScreen.routeName);
                break;
              case 3:
                Navigator.of(context).pushNamed('/profile');
                break;
              //not existing yet
            }
          },
        ),
      ),
    );
  }
}
