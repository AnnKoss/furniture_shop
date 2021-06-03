import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

abstract class FurnitureItemsEvent {}

class FetchFurnitureItemsEvent extends FurnitureItemsEvent {
  final String categoryTitle;
  FetchFurnitureItemsEvent(this.categoryTitle);
}

// class PutFurnitureItemsEvent extends FurnitureItemsEvent {
//   final CatalogueFurnitureItem selectedItem;
//   PutFurnitureItemsEvent(this.selectedItem);
// }

class FurnitureItemsState {}

class FurnitureItemsLoadingState extends FurnitureItemsState {}

class FurnitureItemsLoadedState extends FurnitureItemsState {
  final List<CatalogueFurnitureItem> items;
  FurnitureItemsLoadedState(this.items);
}

class FurnitureItemsErrorState extends FurnitureItemsState {
  final String errorMessage;
  FurnitureItemsErrorState(this.errorMessage);
}

class FurnitureItemsBloc
    extends Bloc<FurnitureItemsEvent, FurnitureItemsState> {
  final FurnitureItemsRepository _service;
  FurnitureItemsBloc(FurnitureItemsState initialState, this._service)
      : super(initialState);

  @override
  Stream<FurnitureItemsState> mapEventToState(FurnitureItemsEvent event) {
    if (event is FetchFurnitureItemsEvent) {
      return _performFetchItems(event);
      // } else if (event is PutFurnitureItemsEvent) {
      //   return _performPutItem(event);
      // } else if (event is RemoveAppointmentEvent) {
      //   return _performRemoveAppointment(event);
      // } else if (event is ChangeVisibleDatesEvent) {
      //   return _performChangeVisibleDates(event);
      // } else if (event is SelectFilterEvent) {
      //   return _performSelectFilter(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<FurnitureItemsState> _performFetchItems(
      FetchFurnitureItemsEvent event) async* {
    yield FurnitureItemsLoadingState();

    List<CatalogueFurnitureItem> loadedItems;
    print('start _performFetchItems');
    try {
      loadedItems = await _service.fetchCategoryItemsList(event.categoryTitle);
      print('loadedItems in _performFetchItems: $loadedItems');
    } on Exception {
      yield FurnitureItemsErrorState(
        'Failed to load items.',
      );
    }

    yield FurnitureItemsLoadedState(loadedItems);
  }

  // Stream<FurnitureItemsState> _performPutItem(
  //     PutFurnitureItemsEvent event) async* {
  //   yield FurnitureItemsLoadingState();

  //   // List<CatalogueFurnitureItem> loadedItems;
  //   print('start _performPutItem');
  //   List<CatalogueFurnitureItem> updatedList;
  //   try {
  //     updatedList = await _service.putFurnitureItem(event.selectedItem);
  //     // print('loadedItems in _performFetchItems: $loadedItems');
  //   } on Exception {
  //     yield FurnitureItemsErrorState(
  //       'Failed to load items.',
  //     );
  //   }

  //   yield FurnitureItemsLoadedState(updatedList);
  // }
}
