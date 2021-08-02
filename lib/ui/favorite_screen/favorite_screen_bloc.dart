import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

abstract class FavoriteScreenEvent {}

class FetchFavotritesEvent extends FavoriteScreenEvent {}

class FavoriteScreenState {}

class FavoriteScreenLoadingState extends FavoriteScreenState {}

class FavoriteScreenLoadedState extends FavoriteScreenState {
  final List<CatalogueFurnitureItem> favoritesList;
  FavoriteScreenLoadedState(this.favoritesList);
}

class FavoriteScreenErrorState extends FavoriteScreenState {
  final String errorMessage;
  FavoriteScreenErrorState(this.errorMessage);
}

class FavoriteScreenBloc
    extends Bloc<FavoriteScreenEvent, FavoriteScreenState> {
  final FurnitureItemsRepository _service;
  FavoriteScreenBloc(FavoriteScreenState initialState, this._service)
      : super(initialState);

  @override
  Stream<FavoriteScreenState> mapEventToState(FavoriteScreenEvent event) {
    if (event is FetchFavotritesEvent) {
      return _performFetchFavorites(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<FavoriteScreenState> _performFetchFavorites(
      FetchFavotritesEvent event) async* {
    yield FavoriteScreenLoadingState();

    List<CatalogueFurnitureItem> favoriteItems;

    try {
      List<CatalogueFurnitureItem> loadedItems =
          await _service.fetchAllItemsList();
      favoriteItems =
          loadedItems.where((element) => element.isFav == true).toList();
    } on Exception {
      yield FavoriteScreenErrorState(
        'Failed to load item.',
      );
    }

    yield FavoriteScreenLoadedState(favoriteItems);
  }
}
