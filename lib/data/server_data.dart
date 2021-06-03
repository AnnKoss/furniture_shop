import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_furniture_shop/domain/category_item.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';
import 'package:flutter_furniture_shop/domain/detail_furniture_item.dart';

List<CategoryItem> categoriesList = [
  CategoryItem(
    'Диваны',
    'бесплатная доставка',
    Image.asset(
      'assets/images/sofas-category-image.png',
    ),
  ),
  CategoryItem(
    'Category Title 1',
    'Category text 1',
    Image.asset(
      'assets/images/sofas-category-image.png',
    ),
  ),
  CategoryItem(
    'Category Title 2',
    'Category Text 2',
    Image.asset(
      'assets/images/sofas-category-image.png',
    ),
  ),
];

String createdJson() {
  String createdJson = jsonEncode(
    catalogueItemsList
        .map(
          (i) => i.toJson(),
        )
        .toList(),
  ).toString();
  print('json: $createdJson');
  return createdJson;
  // String createdJson = json.encode(
  //   catalogueItemsList.map(
  //     (element) {
  //       return {
  //         'title': element.title,
  //         'id': element.id.toString(),
  //         'category': element.category,
  //         'imageUrl': element.imageUrl,
  //         'price': element.price,
  //         'cplprOptions': {
  //           for (int i = 0; i < element.colorOptions.length; i++)
  //             {
  //               element.colorOptions[i].title: element.colorOptions[i].hex,
  //             }
  //         }
  //       };
  //     },
  //   ),
  // );
}

List<CatalogueFurnitureItem> catalogueItemsList = [
  CatalogueFurnitureItem(
    'Диван Бетт',
    1,
    'sofas',
    'assets/images/sofa-bett.png',
    37999,
    [
      ColorStringAndHex('Beige', '0xffB2A39D'),
      ColorStringAndHex('Yellow', '0xffE4B34C'),
      ColorStringAndHex('Gray', '0xffB2A39D'),
    ],
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Свен',
    2,
    'sofas',
    'assets/images/sofa-sven.png',
    25999,
    [
      ColorStringAndHex('Yellow', '0xffE4B34C'),
      ColorStringAndHex('Gray', '0xffB2A39D'),
      ColorStringAndHex('Dark Blue', '0xff505C72'),
    ],
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Рон',
    3,
    'sofas',
    'assets/images/sofa-ron.png',
    19000,
    [
      ColorStringAndHex('Beige', '0xffB2A39D'),
      ColorStringAndHex('Gray', '0xffB2A39D'),
      ColorStringAndHex('Dark Blue', '0xff505C72'),
    ],
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Элиза',
    4,
    'sofas',
    'assets/images/sofa-elisa.png',
    25999,
    [
      ColorStringAndHex('Beige', '0xffB2A39D'),
      ColorStringAndHex('Yellow', '0xffE4B34C'),
      ColorStringAndHex('Gray', '0xffB2A39D'),
    ],
    false,
  ),
];

List<DetailFurnitureItem> detailScreenItemsList = [
  DetailFurnitureItem(
    1,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    [
      '1',
      '2',
      '3',
    ],
    'Delivery',
  ),
  DetailFurnitureItem(
    2,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    [
      '1',
      '2',
      '3',
    ],
    'Delivery',
  ),
  DetailFurnitureItem(
    3,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    [
      '1',
      '2',
      '3',
    ],
    'Delivery',
  ),
  DetailFurnitureItem(
    4,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    [
      '1',
      '2',
      '3',
    ],
    'Delivery',
  ),
];

// Map<String, String> avaliableColors = {
//   'Beige': '0xffB2A39D',
//   'Yellow': '0xffE4B34C',
//   'Gray': '0xff9A9E9F',
//   'Dark Blue': '0xff505C72',
// };
