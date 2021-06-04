import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
import 'package:flutter_furniture_shop/domain/detail_furniture_item.dart';

abstract class DetailScreenItemEvent {}

class FetchDetailScreenItemEvent extends DetailScreenItemEvent {
  final int id;
  FetchDetailScreenItemEvent(this.id);
}

class DetailScreenItemState {}

class DetailScreenItemLoadingState extends DetailScreenItemState {}

class DetailScreenItemLoadedState extends DetailScreenItemState {
  final DetailFurnitureItem item;
  DetailScreenItemLoadedState(this.item);
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
    } else {
      throw UnimplementedError();
    }
  }

  Stream<DetailScreenItemState> _performFetchDetailScreenItem(
      FetchDetailScreenItemEvent event) async* {
    yield DetailScreenItemLoadingState();

    DetailFurnitureItem chosenItem;
    try {
      List<DetailFurnitureItem> fetchedItems =
          await _service.fetchDetailFutnitureItems(event.id);
      chosenItem = fetchedItems.firstWhere(
        (element) {
          return element.id == event.id;
        },
      );
      print('loadedItem in _performFetchDetailScreenItem: $chosenItem');
    } on Exception {
      yield DetailScreenItemErrorState(
        'Failed to load items.',
      );
    }

    yield DetailScreenItemLoadedState(chosenItem);
  }
}
