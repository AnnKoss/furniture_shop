import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

class CartStorage {
  List<CatalogueFurnitureItem> cartItems = [];
  int totalSum = 0;
  //ToDo: Is a storage needed?
}

class CartRepository {
  final CartStorage _storage;
  CartRepository(this._storage);

  int get getTotalSum {
    return _storage.totalSum;
  }

  List<CatalogueFurnitureItem> get getCartItems {
    return _storage.cartItems;
  }

  int changeTotalSum(
    List<CatalogueFurnitureItem> items,
    bool isMinus,
  ) {
    (isMinus)
        ? items.forEach(
            (item) {
              _storage.totalSum = _storage.totalSum - item.price;
            },
          )
        : _storage.totalSum = _storage.totalSum + items[0].price;
    return _storage.totalSum;
  }

  List<CatalogueFurnitureItem> addItem(CatalogueFurnitureItem addedItem) {
    //ToDo: change functions naming
    _storage.cartItems.add(addedItem);
    return _storage.cartItems;
  }

  List<CatalogueFurnitureItem> removeItem(
      List<CatalogueFurnitureItem> removedItems) {
    for (var i = 0; i <= removedItems.length; i++) {
      _storage.cartItems.remove(
        removedItems[i],
      );
    }
    return _storage.cartItems;
  }
}
