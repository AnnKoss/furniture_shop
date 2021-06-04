import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/cart_repository.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

abstract class CartEvent {}

class GetCartItemsEvent extends CartEvent {}

class AddItemToCartEvent extends CartEvent {
  final CatalogueFurnitureItem addedItem;
  AddItemToCartEvent(this.addedItem);
}

class RemoveItemFromCartEvent extends CartEvent {
  final List<CatalogueFurnitureItem> removedItems;
  RemoveItemFromCartEvent(this.removedItems);
}

class ChangeQuantityCartEvent extends CartEvent {
  final bool isMinus;
  final int quantity;
  ChangeQuantityCartEvent(
    this.isMinus,
    this.quantity,
  );
}

// class CartCheckoutEvent extends CartEvent {}
//ToDo: add CartCheckoutEvent

class CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CatalogueFurnitureItem> items;
  final int totalSum;
  CartLoadedState(
    this.items,
    this.totalSum,
  );
}

class CartErrorState extends CartState {
  final String errorMessage;
  CartErrorState(this.errorMessage);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _service;
  CartBloc(CartState initialState, this._service) : super(initialState);

  @override
  Stream<CartState> mapEventToState(CartEvent event) {
    if (event is GetCartItemsEvent) {
      return _performGetCartItems(event);
    } else if (event is AddItemToCartEvent) {
      return _performAddItemToCart(event);
    } else if (event is RemoveItemFromCartEvent) {
      return _performRemoveItemFromCart(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<CartState> _performGetCartItems(GetCartItemsEvent event) async* {
    yield CartLoadingState();

    List<CatalogueFurnitureItem> cartList;
    int totalSum;
    try {
      //ToDo: find out what async syntax is needed with no-async repository operations
      cartList = _service.getCartItems;
      totalSum = _service.getTotalSum;
    } on Exception {
      yield CartErrorState(
        'Failed to load items.',
      );
      //ToDo: change errorState messages
    }

    yield CartLoadedState(
      cartList,
      totalSum,
    );
  }

  Stream<CartState> _performAddItemToCart(AddItemToCartEvent event) async* {
    yield CartLoadingState();

    List<CatalogueFurnitureItem> updatedCartList;
    int totalSum;
    try {
      //ToDo: find out what async syntax is needed with no-async repository operations
      updatedCartList = _service.addItem(event.addedItem);
      totalSum = _service.changeTotalSum(
        [event.addedItem],
        false,
      );

      print('updatedCartList: $updatedCartList');
    } on Exception {
      yield CartErrorState(
        'Failed to load items.',
      );
      //ToDo: change errorState messages
    }

    yield CartLoadedState(
      updatedCartList,
      totalSum,
    );
  }

  Stream<CartState> _performRemoveItemFromCart(
      RemoveItemFromCartEvent event) async* {
    yield CartLoadingState();

    List<CatalogueFurnitureItem> updatedCartList;
    int totalSum;
    try {
      updatedCartList = _service.removeItem(event.removedItems);
      totalSum = _service.changeTotalSum(
        event.removedItems,
        true,
      );

      print('updatedCartList: $updatedCartList');
    } on Exception {
      yield CartErrorState(
        'Failed to load items.',
      );
    }

    yield CartLoadedState(updatedCartList, totalSum);
  }
}
