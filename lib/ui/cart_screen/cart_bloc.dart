import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/cart_repository.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';
import 'package:flutter_furniture_shop/domain/cart_item.dart';

abstract class CartEvent {}

class GetCartItemsEvent extends CartEvent {}

class AddItemToCartEvent extends CartEvent {
  final CatalogueFurnitureItem addedItem;
  AddItemToCartEvent(this.addedItem);
}

class RemoveItemFromCartEvent extends CartEvent {
  final CatalogueFurnitureItem removedItem;
  final bool isAllRemoved;
  RemoveItemFromCartEvent(
    this.removedItem,
    this.isAllRemoved,
  );
}

class ChangeIsCheckedEvent extends CartEvent {
  final int id;
  ChangeIsCheckedEvent(this.id);
}

// class CartCheckoutEvent extends CartEvent {}
//ToDo: add CartCheckoutEvent

class CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItem> items;
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
    } else if (event is ChangeIsCheckedEvent) {
      return _performChangeIsChecked(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<CartState> _performGetCartItems(GetCartItemsEvent event) async* {
    yield CartLoadingState();

    List<CartItem> cartList;
    int totalSum;
    try {
      //ToDo: find out what async syntax is needed with no-async repository operations
      cartList = _service.getCartItems;
      totalSum = _service.getTotalSum;
    } on Exception {
      yield CartErrorState(
        'Failed to load items.',
      );
    }

    yield CartLoadedState(
      cartList,
      totalSum,
    );
  }

  Stream<CartState> _performAddItemToCart(AddItemToCartEvent event) async* {
    yield CartLoadingState();

    List<CartItem> updatedCartList = [];
    int totalSum;
    try {
      //ToDo: find out what async syntax is needed with no-async repository operations
      updatedCartList = _service.addItem(event.addedItem);
      totalSum = _service.changeTotalSum(
        event.addedItem.price,
        false,
      );
    } on Exception {
      yield CartErrorState(
        'Failed to add item.',
      );
    }

    yield CartLoadedState(
      updatedCartList,
      totalSum,
    );
  }

  Stream<CartState> _performRemoveItemFromCart(
      RemoveItemFromCartEvent event) async* {
    yield CartLoadingState();

    List<CartItem> updatedCartList = [];
    int totalSum;
    try {
      updatedCartList = _service.removeItem(
        event.removedItem,
        event.isAllRemoved,
      );
      totalSum = _service.changeTotalSum(
        event.removedItem.price,
        true,
      );
    } on Exception {
      yield CartErrorState(
        'Failed to remove item.',
      );
    }

    yield CartLoadedState(updatedCartList, totalSum);
  }

  Stream<CartState> _performChangeIsChecked(ChangeIsCheckedEvent event) async* {
    yield CartLoadingState();

    List<CartItem> updatedCartList;
    int totalSum;
    try {
      updatedCartList = _service.changeIsChecked(event.id);

      totalSum = _service.changeTotalSum(0, false);
    } on Exception {
      yield CartErrorState(
        'Something went wrong.',
      );
    }

    yield CartLoadedState(updatedCartList, totalSum);
  }
}
