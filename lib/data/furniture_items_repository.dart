import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';
import 'package:flutter_furniture_shop/data/server_data.dart';

class ItemsStorage {
  List<CatalogueFurnitureItem> catalogueFurnitureItems = [];
  // List<CatalogueFurnitureItem> catalogueFurnitureItems = catalogueItemsList;
}

class FurnitureItemsRepository {
  final ItemsStorage _storage;
  FurnitureItemsRepository(this._storage);

  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<List<CatalogueFurnitureItem>> putFurnitureItem(
  //     CatalogueFurnitureItem selectedItem) async {
  //   final String url =
  //       'https://test-furniture-shop.firebaseio.com/categories/sofas.json';
  //   try {
  //     print('repository try putFurnitureItem');
  //     http.put(
  //       url,
  //       body: json.encode(
  //         {
  //           'title': selectedItem.title,
  //           'price': selectedItem.price,
  //           'avaliableColors': {
  //             for (int i = 0; i < selectedItem.colorOptions.length; i++)
  //               {
  //                 selectedItem.colorOptions[i].title:
  //                     selectedItem.colorOptions[i].hex,
  //               }
  //           }
  //         },
  //       ),
  //     );
  //     // firestore.collection('sofas').add(
  //     //   {
  //     //     'title': selectedItem.title,
  //     //     'price': selectedItem.price,
  //     //     'avaliableColors': {
  //     //       for (int i = 0; i < selectedItem.colorOptions.length; i++)
  //     //         {
  //     //           selectedItem.colorOptions[i].title:
  //     //               selectedItem.colorOptions[i].hex,
  //     //         }
  //     //     }
  //     //   },
  //     // );
  //     CatalogueFurnitureItem addedItem = CatalogueFurnitureItem(
  //       selectedItem.title,
  //       selectedItem.id,
  //       selectedItem.category,
  //       selectedItem.imageUrl,
  //       selectedItem.price,
  //       selectedItem.colorOptions,
  //       selectedItem.isFav,
  //     );
  //     _storage.catalogueFurnitureItems.add(addedItem);
  //     return _storage.catalogueFurnitureItems;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  List<CatalogueFurnitureItem> parseItems(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<CatalogueFurnitureItem>(
            (json) => CatalogueFurnitureItem.fromJson(json))
        .toList();
  }

  Future<List<CatalogueFurnitureItem>> fetchCategoryItemsList(
      String categoryTitle) async {
    if (_storage.catalogueFurnitureItems.isNotEmpty) {
      return _storage.catalogueFurnitureItems;
    } else {
      _storage.catalogueFurnitureItems = parseItems(
        createdJson(),
      );
      print('storage items: ${_storage.catalogueFurnitureItems}');
      return _storage.catalogueFurnitureItems;
      // final String url =
      //     'https://test-furniture-shop.firebaseio.com/categories/$categoryTitle.json';
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
    }
  }
}
