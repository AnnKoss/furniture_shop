import 'package:flutter/cupertino.dart';

class CategoryItem {
  ///Category of [CatalogueFurnitureItem].
  final String title;
  final String text;
  final Image image;
  final String category;

  CategoryItem(
    this.title,
    this.text,
    this.image,
    this.category,
  );
}
