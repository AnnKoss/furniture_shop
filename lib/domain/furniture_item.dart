import 'package:flutter/material.dart';

class FurnitureItem {
  String category;
  Image image;
  String title;
  int price;
  List<ColorHexAndString> colorOptions;
  bool isFav;
  String description;

  FurnitureItem(
    this.category,
    this.image,
    this.title,
    this.price,
    this.colorOptions,
    this.isFav,
    this.description,
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
