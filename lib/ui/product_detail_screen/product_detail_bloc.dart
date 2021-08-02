import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
import 'package:flutter_furniture_shop/domain/detail_furniture_item.dart';

abstract class DetailScreenItemEvent {}

class FetchDetailScreenItemEvent extends DetailScreenItemEvent {
  final int id;
  bool isFav;
  FetchDetailScreenItemEvent(
    this.id,
    this.isFav,
  );
}

class ToggleIsDetailFavouriteEvent extends DetailScreenItemEvent {
  final int id;
  ToggleIsDetailFavouriteEvent(this.id);
}

class DetailScreenItemState {}

class DetailScreenItemLoadingState extends DetailScreenItemState {}

class DetailScreenItemLoadedState extends DetailScreenItemState {
  final DetailFurnitureItem item;
  bool isFav;
  DetailScreenItemLoadedState(
    this.item,
    this.isFav,
  );
}

class DetailScreenItemErrorState extends DetailScreenItemState {
  final String errorMessage;
  DetailScreenItemErrorState(this.errorMessage);
}

class DetailScreenItemBloc
    extends Bloc<DetailScreenItemEvent, DetailScreenItemState> {
  final FurnitureItemsRepository _service;
  DetailScreenItemBloc(DetailScreenItemState initialState, this._service)
      : super(initialState);

  @override
  Stream<DetailScreenItemState> mapEventToState(DetailScreenItemEvent event) {
    if (event is FetchDetailScreenItemEvent) {
      return _performFetchDetailScreenItem(event);
    } else if (event is ToggleIsDetailFavouriteEvent) {
      return _performToggleIsFavouriteItem(event);
    } else {
      throw UnimplementedError();
    }
  }

  DetailFurnitureItem chosenItem;
  bool isFav;

  Stream<DetailScreenItemState> _performFetchDetailScreenItem(
      FetchDetailScreenItemEvent event) async* {
    yield DetailScreenItemLoadingState();

    try {
      List<DetailFurnitureItem> fetchedItems =
          await _service.fetchDetailFutnitureItems(event.id);

      chosenItem = fetchedItems.firstWhere(
        (element) {
          return element.id == event.id;
        },
      );

      isFav = event.isFav;
    } on Exception {
      yield DetailScreenItemErrorState(
        'Failed to load item.',
      );
    }

    yield DetailScreenItemLoadedState(
      chosenItem,
      isFav,
    );
  }

  Stream<DetailScreenItemState> _performToggleIsFavouriteItem(
      ToggleIsDetailFavouriteEvent event) async* {
    yield DetailScreenItemLoadingState();

    try {
      await _service.toggleIsFavourite(event.id);

      isFav = !isFav;
    } on Exception {
      yield DetailScreenItemErrorState(
        'Failed to load items.',
      );
    }

    yield DetailScreenItemLoadedState(
      chosenItem,
      isFav,
    );
  }
}
