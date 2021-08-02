import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';
import 'package:flutter_furniture_shop/domain/detail_furniture_item.dart';
import 'package:flutter_furniture_shop/data/server_data.dart';

class ItemsStorage {
  List<CatalogueFurnitureItem> catalogueFurnitureItems = [];
  List<DetailFurnitureItem> detailFurnitureItems = [];
}

class FurnitureItemsRepository {
  final ItemsStorage _storage;
  FurnitureItemsRepository(this._storage);

  Future<List<CatalogueFurnitureItem>> fetchAllItemsList() async {
    if (_storage.catalogueFurnitureItems.isNotEmpty) {
      return _storage.catalogueFurnitureItems;
    } else {
      _storage.catalogueFurnitureItems = List<CatalogueFurnitureItem>.from(
        jsonDecode(jsonEncode(catalogueItemsList)).map(
          (item) => CatalogueFurnitureItem.fromJson(item),
        ),
      );
      //jsonEncode(catalogueItemsList) is a generated json from server_data file. Should be replaced with real server data.
      //Sample code for fetching data from FireBase:

      // final String url =
      //     'https://test-furniture-shop.firebaseio.com/categories.json';
      // // final List<CatalogueFurnitureItem> loadedItems = [];
      // // try {
      // final response = await http.get(url);
      // print('response body: ${response.body}');
      // if (response.statusCode == 200) {
      //   _storage.catalogueFurnitureItems = parseItems(response.body);
      //   return _storage.catalogueFurnitureItems;
      //   // CatalogueFurnitureItem.fromJson(
      //   //   jsonDecode(response.body),
      //   // );
      // } else {
      //   throw Exception('Failed to load items');
      // }

      print('storage items: ${_storage.catalogueFurnitureItems}');
      return _storage.catalogueFurnitureItems;
    }
  }

  Future<List<DetailFurnitureItem>> fetchDetailFutnitureItems(int id) async {
    if (_storage.detailFurnitureItems.isNotEmpty) {
      return _storage.detailFurnitureItems;
    } else {
      _storage.detailFurnitureItems = List<DetailFurnitureItem>.from(
        jsonDecode(jsonEncode(detailScreenItemsList)).map(
          (item) => DetailFurnitureItem.fromJson(item),
        ),
      );
      print('_storage.detailFurnitureItems: ${_storage.detailFurnitureItems}');
      return _storage.detailFurnitureItems;
    }
  }

  Future<List<CatalogueFurnitureItem>> toggleIsFavourite(int id) async {
    CatalogueFurnitureItem item = _storage.catalogueFurnitureItems.firstWhere((element) => element.id == id);
    item.isFav = !item.isFav;
    return _storage.catalogueFurnitureItems;
  }
}
