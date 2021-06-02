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

List<CatalogueFurnitureItem> catalogueItemsList = [
  CatalogueFurnitureItem(
    'Диван Бетт',
    1,
    'Sofas',
    'assets/images/sofa-bett.png',
    37999,
    [
      avaliableColors['Beige'],
      avaliableColors['Yellow'],
      avaliableColors['Gray'],
    ],
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Свен',
    2,
    'Sofas',
    'assets/images/sofa-sven.png',
    25999,
    [
      avaliableColors['Yellow'],
      avaliableColors['Gray'],
      avaliableColors['Dark Blue'],
    ],
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Рон',
    3,
    'Sofas',
    'assets/images/sofa-ron.png',
    19000,
    [
      avaliableColors['Beige'],
      avaliableColors['Gray'],
      avaliableColors['Dark Blue'],
    ],
    false,
  ),
  CatalogueFurnitureItem(
    'Диван Элиза',
    4,
    'Sofas',
    'assets/images/sofa-elisa.png',
    25999,
    [
      avaliableColors['Beige'],
      avaliableColors['Yellow'],
      avaliableColors['Gray'],
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

Map<String, String> avaliableColors = {
  'Beige': '0xffB2A39D',
  'Yellow': '0xffE4B34C',
  'Gray': '0xff9A9E9F',
  'Dark Blue': '0xff505C72',
};
