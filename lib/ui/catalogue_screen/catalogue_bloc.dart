import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

abstract class CatalogueItemsEvent {}

class FetchAllCatalogueItemsEvent extends CatalogueItemsEvent {}

class FetchCatalogueCategoryItemsEvent extends CatalogueItemsEvent {
  final String categoryTitle;
  FetchCatalogueCategoryItemsEvent(this.categoryTitle);
}

class FilterCatalogueItemsEvent extends CatalogueItemsEvent {
  final RangeValues priceFilter;
  final Set<ColorFilter> colorFilter;
  FilterCatalogueItemsEvent(
    this.priceFilter,
    this.colorFilter,
  );
}

class ToggleIsFavouriteEvent extends CatalogueItemsEvent {
  final int id;
  ToggleIsFavouriteEvent(this.id);
}

class CatalogueItemsState {}

class CatalogueItemsLoadingState extends CatalogueItemsState {}

class CatalogueItemsLoadedState extends CatalogueItemsState {
  final List<CatalogueFurnitureItem> filteredItems;
  final Filter filter;
  CatalogueItemsLoadedState(
    this.filteredItems,
    this.filter,
  );
}

class CatalogueItemsErrorState extends CatalogueItemsState {
  final String errorMessage;
  CatalogueItemsErrorState(this.errorMessage);
}

class CatalogueItemsBloc
    extends Bloc<CatalogueItemsEvent, CatalogueItemsState> {
  final FurnitureItemsRepository _service;
  CatalogueItemsBloc(CatalogueItemsState initialState, this._service)
      : super(initialState);

  @override
  Stream<CatalogueItemsState> mapEventToState(CatalogueItemsEvent event) {
    if (event is FetchCatalogueCategoryItemsEvent) {
      return _performFetchCategoryItems(event);
    } else if (event is FetchAllCatalogueItemsEvent) {
      return _performFetchAllItems(event);
    } else if (event is FilterCatalogueItemsEvent) {
      return _performFilterItems(event);
    } else if (event is ToggleIsFavouriteEvent) {
      return _performToggleIsFavouriteItem(event);
    } else {
      throw UnimplementedError();
    }
  }

  
  List<CatalogueFurnitureItem> _loadedItems = [];
  List<CatalogueFurnitureItem> _filteredItems = [];

  double _maxPrice;
  RangeValues _priceFilter = null;
  Set<ColorFilter> _colorFilter = null;


  Stream<CatalogueItemsState> _performFetchAllItems(
      FetchAllCatalogueItemsEvent event) async* {
    yield CatalogueItemsLoadingState();

    try {
      _loadedItems = await _service.fetchAllItemsList();

      _loadedItems.sort(
        (a, b) {
          return a.price.compareTo(b.price);
        },
      );
      _maxPrice = _loadedItems[_loadedItems.length - 1].price.toDouble();
      print('maxPrice: $_maxPrice');
    } on Exception {
      yield CatalogueItemsErrorState(
        'Failed to load items.',
      );
    }

    yield CatalogueItemsLoadedState(
      _loadedItems,
      Filter(
        null,
        null,
        _maxPrice,
      ),
    );
  }

  Stream<CatalogueItemsState> _performFetchCategoryItems(
      FetchCatalogueCategoryItemsEvent event) async* {
    yield CatalogueItemsLoadingState();

    try {
      if (_loadedItems.isNotEmpty) {
        _filteredItems = _loadedItems
            .where(
              (element) => element.category == event.categoryTitle,
            )
            .toList();
      }
    } on Exception {
      yield CatalogueItemsErrorState(
        'Failed to load items.',
      );
    }

    yield CatalogueItemsLoadedState(
      _filteredItems,
      Filter(
        null,
        null,
        _maxPrice,
      ),
    );
  }

  Stream<CatalogueItemsState> _performFilterItems(
      FilterCatalogueItemsEvent event) async* {
    yield CatalogueItemsLoadingState();

    Set<ColorStringAndHex> _selectedColors;
    try {
      _priceFilter = event.priceFilter;
      _colorFilter = event.colorFilter;

      _selectedColors = (_colorFilter != null)
          ? _colorFilter.where((element) => element.isChecked == true).map(
              (e) {
                return ColorStringAndHex(e.title, e.color);
              },
            ).toSet()
          : null;

      _filteredItems = _loadedItems
          .where(
            (item) => ((_priceFilter == null ||
                    (_priceFilter.start <= item.price &&
                        item.price <= _priceFilter.end)) &&
                (_colorFilter == null ||
                    item.colorOptions
                        .intersection(_colorFilter)
                        .isNotEmpty)),
          )
          .toList();
    } on Exception {
      yield CatalogueItemsErrorState(
        'Failed to load items.',
      );
    }

    yield CatalogueItemsLoadedState(
      _filteredItems,
      Filter(
        event.priceFilter,
        _selectedColors,
        _maxPrice,
      ),
    );
  }

  Stream<CatalogueItemsState> _performToggleIsFavouriteItem(
      ToggleIsFavouriteEvent event) async* {
    yield CatalogueItemsLoadingState();

    Set<ColorStringAndHex> _selectedColors;
    try {
      _loadedItems = await _service.toggleIsFavourite(event.id);
      _selectedColors = (_colorFilter != null)
          ? _colorFilter.where((element) => element.isChecked == true).map(
              (e) {
                return ColorStringAndHex(e.title, e.color);
              },
            ).toSet()
          : null;
      //ToDo: avoid code duplication
      if (_filteredItems.isEmpty) {
        _filteredItems = _loadedItems;
      }
    } on Exception {
      yield CatalogueItemsErrorState(
        'Failed to load items.',
      );
    }

    yield CatalogueItemsLoadedState(
      _filteredItems,
      Filter(
        _priceFilter,
        _selectedColors,
        _maxPrice,
      ),
    );
  }
}

class Filter {
  final RangeValues priceFilter;
  final Set<ColorStringAndHex> colorFilter;
  final double maxPrice;
  Filter(
    this.priceFilter,
    this.colorFilter,
    this.maxPrice,
  );
}

class ColorFilter {
  final String title;
  final String color;
  bool isChecked;
  ColorFilter(
    this.title,
    this.color,
    this.isChecked,
  );
}
