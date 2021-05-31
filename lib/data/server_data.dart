import 'package:flutter/material.dart';

import 'package:flutter_furniture_shop/domain/category_item.dart';
import 'package:flutter_furniture_shop/domain/furniture_item.dart';

List<CategoryItem> categoriesList = [
  CategoryItem('Диваны', 'бесплатная доставка'),
  CategoryItem('Category Title 1', 'Category text 1'),
  CategoryItem('Category Title 2', 'Category Text 2'),
];

// List<String> filterList = <String>[
//   'Цвет',
//   'Стоимость',
// ];

List<FurnitureItem> furnitureItemsList = [
  FurnitureItem(
    'Диваны',
    Image.asset(
      'assets/images/sofas-category-image.png',
    ),
    'Диван Бетт',
    37999,
    [
      ColorHexAndString(
        '0xffB2A39D',
        'Beige',
      ),
      ColorHexAndString(
        '0xffE4B34C',
        'Yellow',
      ),
      ColorHexAndString(
        '0xff9A9E9F',
        'Gray',
      ),
    ],
    false,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
];
