import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CatalogueFurnitureItem {
  final String title;
  final int id;
  //if implemented with FireBase, will be taken from server side
  final String category;
  final String imageUrl;
  final int price;
  final List<ColorStringAndHex> colorOptions;
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

  factory CatalogueFurnitureItem.fromJson(Map<String, dynamic> json) {
    return CatalogueFurnitureItem(
      json['title'] as String,
      json['id'] as int,
      json['category'] as String,
      json['imageUrl'] as String,
      json['price'] as int,
      json['colorOptions'] as List<ColorStringAndHex>,
      json['isFav'] as bool,
    );
  }
        

  Map<String, dynamic> toJson() {
    
    return {
      'title': this.title,
      'id': this.id,
      'category': this.category,
      'imageUrl': this.imageUrl,
      'price': this.price,
      // 'colorOptions': {
      //   for (int i = 0; i < this.colorOptions.length; i++)
      //     {
      //       this.colorOptions[i].title: this.colorOptions[i].hex,
      //     }
      // },
      'isFav': this.isFav,
    };
  }
}

class ColorStringAndHex {
  String title;
  String hex;

  ColorStringAndHex(
    this.title,
    this.hex,
  );
}
