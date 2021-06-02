import 'package:flutter/material.dart';

class CatalogueFurnitureItem {
  final String title;
  final int id;
  //if implemented with FireBase, will be taken from server side
  final String category;
  final String imageUrl;
  final int price;
  final List<String> colorOptions;
  final bool isFav;

  CatalogueFurnitureItem(
    this.title,
    this.id,
    this.category,
    this.imageUrl,
    this.price,
    this.colorOptions,
    this.isFav,
  );
}

class ColorHexAndString {
  String hex;
  String title;

  ColorHexAndString(
    this.hex,
    this.title,
  );
}

ColorHexAndString beige = ColorHexAndString(
  '0xffB2A39D',
  'Beige',
);
