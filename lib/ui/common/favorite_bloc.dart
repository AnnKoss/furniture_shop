// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_furniture_shop/data/furniture_items_repository.dart';
// import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

// abstract class FavoriteItemEvent {}

// class GetIsFavoriteItemEvent extends FavoriteItemEvent {
//   final int id;
//   GetIsFavoriteItemEvent(this.id);
// }

// class ToggleIsFavoriteItemEvent extends FavoriteItemEvent {
//   final int id;
//   ToggleIsFavoriteItemEvent(this.id);
// }

// class FavoriteItemState {}

// class FavoriteItemLoadingState extends FavoriteItemState {}

// class FavoriteItemLoadedState extends FavoriteItemState {
//   final bool isFav;
//   FavoriteItemLoadedState(this.isFav);
// }

// class FavoriteItemErrorState extends FavoriteItemState {
//   final String errorMessage;
//   FavoriteItemErrorState(this.errorMessage);
// }

// class FavoriteItemBloc extends Bloc<FavoriteItemEvent, FavoriteItemState> {
//   final FurnitureItemsRepository _service;
//   FavoriteItemBloc(FavoriteItemState initialState, this._service)
//       : super(initialState);

//   @override
//   Stream<FavoriteItemState> mapEventToState(FavoriteItemEvent event) {
//     if (event is GetIsFavoriteItemEvent) {
//       return _performGetIsFavouriteItem(event);
//     } else if (event is ToggleIsFavoriteItemEvent) {
//       return _performToggleIsFavouriteItem(event);
//     } else {
//       throw UnimplementedError();
//     }
//   }

//   bool isFav = false;

//   Stream<FavoriteItemState> _performGetIsFavouriteItem(
//       GetIsFavoriteItemEvent event) async* {
//     yield FavoriteItemLoadingState();

//     try {
//       List<CatalogueFurnitureItem> loadedItems =
//           await _service.fetchAllItemsList();

//       isFav = loadedItems.firstWhere((element) => element.id == event.id).isFav;
//     } on Exception {
//       yield FavoriteItemErrorState(
//         'Something went wrong.',
//       );
//     }

//     yield FavoriteItemLoadedState(
//       isFav,
//     );
//   }

//   Stream<FavoriteItemState> _performToggleIsFavouriteItem(
//       ToggleIsFavoriteItemEvent event) async* {
//     yield FavoriteItemLoadingState();

//     try {
//       await _service.toggleIsFavourite(event.id);

//       isFav = !isFav;
//     } on Exception {
//       yield FavoriteItemErrorState(
//         'Something went wrong.',
//       );
//     }

//     yield FavoriteItemLoadedState(
//       isFav,
//     );
//   }
// }
