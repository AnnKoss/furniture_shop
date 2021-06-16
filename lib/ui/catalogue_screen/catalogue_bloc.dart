import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

abstract class FurnitureItemsEvent {}

class FetchAllFurnitureItemsEvent extends FurnitureItemsEvent {}

class FetchFurnitureCategoryItemsEvent extends FurnitureItemsEvent {
  final String categoryTitle;
  FetchFurnitureCategoryItemsEvent(this.categoryTitle);
}

class FilterItemsEvent extends FurnitureItemsEvent {
  final RangeValues priceFilter;
  final Set<ColorStringAndHex> colorFilter;
  FilterItemsEvent(
    this.priceFilter,
    this.colorFilter,
  );
}

class FurnitureItemsState {}

class FurnitureItemsLoadingState extends FurnitureItemsState {}

class FurnitureItemsLoadedState extends FurnitureItemsState {
  final List<CatalogueFurnitureItem> allItems;
  final List<CatalogueFurnitureItem> filteredItems;
  FurnitureItemsLoadedState(
    this.allItems,
    this.filteredItems,
  );
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
    } else if (event is FilterItemsEvent) {
      return _performFilterItems(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<FurnitureItemsState> _performFetchAllItems(
      FetchAllFurnitureItemsEvent event) async* {
    yield FurnitureItemsLoadingState();

    List<CatalogueFurnitureItem> _loadedItems;
    try {
      _loadedItems = await _service.fetchAllItemsList();
    } on Exception {
      yield FurnitureItemsErrorState(
        'Failed to load items.',
      );
    }

    yield FurnitureItemsLoadedState(
      _loadedItems,
      _loadedItems,
    );
  }

  Stream<FurnitureItemsState> _performFetchCategoryItems(
      FetchFurnitureCategoryItemsEvent event) async* {
    yield FurnitureItemsLoadingState();

    List<CatalogueFurnitureItem> _filteredItems = [];
    List<CatalogueFurnitureItem> _loadedItems = [];
    try {
      _loadedItems = await _service.fetchAllItemsList();
      if (_loadedItems.isNotEmpty) {
        _filteredItems = _loadedItems
            .where(
              (element) => element.category == event.categoryTitle,
            )
            .toList();
      }
    } on Exception {
      yield FurnitureItemsErrorState(
        'Failed to load items.',
      );
    }

    yield FurnitureItemsLoadedState(
      _loadedItems,
      _filteredItems,
    );
  }

  Stream<FurnitureItemsState> _performFilterItems(
      FilterItemsEvent event) async* {
    yield FurnitureItemsLoadingState();

    List<CatalogueFurnitureItem> _filteredItems = [];
    List<CatalogueFurnitureItem> _loadedItems = [];
    try {
      _loadedItems = await _service.fetchAllItemsList();

      _filteredItems = _loadedItems
          .where(
            (item) => (
              (event.priceFilter == null ||
                    (event.priceFilter.start <= item.price &&
                        item.price <= event.priceFilter.end)) &&
                (event.colorFilter == null ||
                    item.colorOptions
                        .intersection(event.colorFilter)
                        .isNotEmpty)),
          )
          .toList();
    } on Exception {
      yield FurnitureItemsErrorState(
        'Failed to load items.',
      );
    }

    yield FurnitureItemsLoadedState(
      _loadedItems,
      _filteredItems,
    );
  }
}
