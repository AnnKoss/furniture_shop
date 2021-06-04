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

  List parseItems(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<CatalogueFurnitureItem>(
            (json) => CatalogueFurnitureItem.fromJson(json))
        .toList();
  }

  Future<List<CatalogueFurnitureItem>> fetchAllItemsList() async {
    if (_storage.catalogueFurnitureItems.isNotEmpty) {
      return _storage.catalogueFurnitureItems;
    } else {
      _storage.catalogueFurnitureItems = parseItems(
        createdJson(catalogueItemsList),
      );
      //createdJson(catalogueItemsList) is a generated json from server_data file. Should be replaced with real server data. 
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
      _storage.detailFurnitureItems = parseItems(
        createdJson(detailScreenItemsList),
      );
      print('storage items: ${_storage.catalogueFurnitureItems}');
      return _storage.detailFurnitureItems;
    }
  }
}
