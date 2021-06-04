import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

abstract class FurnitureItemsEvent {}

class FetchAllFurnitureItemsEvent extends FurnitureItemsEvent {}

class FetchFurnitureCategoryItemsEvent extends FurnitureItemsEvent {
  final String categoryTitle;
  FetchFurnitureCategoryItemsEvent(this.categoryTitle);
}

class SelectFilterEvent extends FurnitureItemsEvent {
  final String filterValue;
  SelectFilterEvent(this.filterValue);
}

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
    if (event is FetchFurnitureCategoryItemsEvent) {
      return _performFetchCategoryItems(event);
    } else if (event is FetchAllFurnitureItemsEvent) {
      return _performFetchAllItems(event);
      // } else if (event is SelectFilterEvent) {
      //   return _performSelectFilter(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<FurnitureItemsState> _performFetchAllItems(
      FetchAllFurnitureItemsEvent event) async* {
    yield FurnitureItemsLoadingState();

    List<CatalogueFurnitureItem> loadedItems;
    print('start _performFetchItems');
    try {
      loadedItems = await _service.fetchAllItemsList();
      print('loadedItems in _performFetchItems: $loadedItems');
    } on Exception {
      yield FurnitureItemsErrorState(
        'Failed to load items.',
      );
    }

    yield FurnitureItemsLoadedState(loadedItems);
  }

  Stream<FurnitureItemsState> _performFetchCategoryItems(
      FetchFurnitureCategoryItemsEvent event) async* {
    yield FurnitureItemsLoadingState();

    List<CatalogueFurnitureItem> categoryItems = [];
    List<CatalogueFurnitureItem> loadedItems = [];
    print('start _performFetchItems');
    try {
      loadedItems = await _service.fetchAllItemsList();
      categoryItems = loadedItems
          .where(
            (element) => element.category == event.categoryTitle,
          )
          .toList();
      print('loadedItems in _performFetchItems: $loadedItems');
    } on Exception {
      yield FurnitureItemsErrorState(
        'Failed to load items.',
      );
    }

    yield FurnitureItemsLoadedState(categoryItems);
  }

  // Stream<FurnitureItemsState> _performSelectFilter(
  //     SelectFilterEvent event) async* {
  //   yield FurnitureItemsLoadingState();

  //   List<CatalogueFurnitureItem> filteredItems;
  //   print('start _performFetchItems');
  //   try {
  //     loadedItems = await _service.fetchCategoryItemsList(event.categoryTitle);
  //     // print('loadedItems in _performFetchItems: $loadedItems');
  //     loadedItems.
  //   } on Exception {
  //     yield FurnitureItemsErrorState(
  //       'Failed to load items.',
  //     );
  //   }

  //   yield FurnitureItemsLoadedState(loadedItems);
  // }
}
