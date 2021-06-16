import 'dart:convert';
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
      'sofas'),
  CategoryItem(
      'Category Title 1',
      'Category text 1',
      Image.asset(
        'assets/images/sofas-category-image.png',
      ),
      'category2'),
  CategoryItem(
      'Category Title 2',
      'Category Text 2',
      Image.asset(
        'assets/images/sofas-category-image.png',
      ),
      'category3'),
];

List<CatalogueFurnitureItem> catalogueItemsList = [
  CatalogueFurnitureItem(
    'Диван Бетт',
    1,
    'sofas',
    'assets/images/sofa-bett.png',
    37999,
    {
      ColorStringAndHex('Beige', '0xffB2A39D'),
      ColorStringAndHex('Yellow', '0xffE4B34C'),
      ColorStringAndHex('Gray', '0xff9A9E9F'),
    },
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Свен',
    2,
    'sofas',
    'assets/images/sofa-sven.png',
    25999,
    {
      ColorStringAndHex('Yellow', '0xffE4B34C'),
      ColorStringAndHex('Gray', '0xff9A9E9F'),
      ColorStringAndHex('Dark Blue', '0xff505C72'),
    },
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Рон',
    3,
    'sofas',
    'assets/images/sofa-ron.png',
    19000,
    {
      ColorStringAndHex('Beige', '0xffB2A39D'),
      ColorStringAndHex('Gray', '0xff9A9E9F'),
      ColorStringAndHex('Dark Blue', '0xff505C72'),
    },
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Элиза',
    4,
    'sofas',
    'assets/images/sofa-elisa.png',
    25999,
    {
      ColorStringAndHex('Beige', '0xffB2A39D'),
      ColorStringAndHex('Yellow', '0xffE4B34C'),
      ColorStringAndHex('Gray', '0xff9A9E9F'),
    },
    false,
  ),
];

List<DetailFurnitureItem> detailScreenItemsList = [
  DetailFurnitureItem(
    1,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    [
      'review 1',
      'review 2',
      'review 3',
    ],
    'Delivery',
  ),
  DetailFurnitureItem(
    2,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    [
      'review 1',
      'review 2',
      'review 3',
    ],
    'Delivery',
  ),
  DetailFurnitureItem(
    3,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    [
      'review 1',
      'review 2',
      'review 3',
    ],
    'Delivery',
  ),
  DetailFurnitureItem(
    4,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    [
      'review 1',
      'review 2',
      'review 3',
    ],
    'Delivery',
  ),
];
