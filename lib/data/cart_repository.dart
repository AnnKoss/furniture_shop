import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';
import 'package:flutter_furniture_shop/domain/cart_item.dart';

class CartStorage {
  List<CartItem> cartItems = [];
  int totalSum = 0;
}

class CartRepository {
  final CartStorage _storage;
  CartRepository(this._storage);

  int get getTotalSum {
    return _storage.totalSum;
  }

  List<CartItem> get getCartItems {
    return _storage.cartItems;
  }

  int changeTotalSum(
    int price,
    bool isMinus,
  ) {
    (isMinus)
        ? _storage.totalSum = _storage.totalSum - price
        : _storage.totalSum = _storage.totalSum + price;
    return _storage.totalSum;
  }

  List<CartItem> addItem(CatalogueFurnitureItem addedItem) {
    //ToDo: change functions naming
    if (_storage.cartItems.any((element) => element.item.id == addedItem.id)) {
      _storage.cartItems
          .firstWhere((element) => element.item.id == addedItem.id)
          .quantity += 1;
    } else {
      _storage.cartItems.add(
        CartItem(
          item: addedItem,
          quantity: 1,
        ),
      );
    }

    return _storage.cartItems;
  }

  List<CartItem> removeItem(
    CatalogueFurnitureItem removedItem,
    bool isAllRemoved,
  ) {
    if ((_storage.cartItems
                .firstWhere((element) => element.item.id == removedItem.id)
                .quantity ==
            1) ||
        (isAllRemoved = true)) {
      _storage.cartItems.removeWhere(
        (element) => element.item.id == removedItem.id,
      );
    } else {
      _storage.cartItems
          .firstWhere((element) => element.item.id == removedItem.id)
          .quantity -= 1;
    }

    return _storage.cartItems;
  }

  List<CartItem> changeIsChecked(int id) {
    if (_storage.cartItems.isNotEmpty) {
      CartItem checkedItem =
          _storage.cartItems.firstWhere((element) => element.item.id == id);
      checkedItem.isChecked = !checkedItem.isChecked;
    }

    return _storage.cartItems;
  }
}
