import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

class CartItem {
  final CatalogueFurnitureItem item;
  int quantity;
  bool isChecked;
  CartItem({
    this.item,
    this.quantity,
    this.isChecked = false,
  });
}
