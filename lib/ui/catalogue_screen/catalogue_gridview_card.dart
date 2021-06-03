import 'package:flutter/material.dart';

import 'package:flutter_furniture_shop/ui/common/styles.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

class GridViewCard extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final List<ColorStringAndHex> colorOptions;
  final int price;
  GridViewCard(
    this.id,
    this.title,
    this.imageUrl,
    this.colorOptions,
    this.price,
  );
  @override
  _GridViewCardState createState() => _GridViewCardState();
}

class _GridViewCardState extends State<GridViewCard> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pushNamed(
        '/product-detail',
        arguments: ScreenArguments(
          widget.id,
          widget.title,
          widget.imageUrl,
          widget.price,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffEFF0F6),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.imageUrl,
              ),
              //Image.asset is a temporary solution
            ),
            SizedBox(height: 9),
            Row(
              children: widget.colorOptions.map(
                (ColorStringAndHex colorStringAndHex) {
                  return _colorAvatarBuilder(colorStringAndHex.hex);
                },
              ).toList(),
            ),
            SizedBox(height: 33),
            Text(
              widget.title,
              style: gridviewCardTitle,
            ),
            Text(
              '${widget.price} Руб',
              style: gridviewCardPrice,
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final int id;
  final String title;
  final String imageUrl;
  final int price;

  ScreenArguments(
    this.id,
    this.title,
    this.imageUrl,
    this.price,
  );
}

Widget _colorAvatarBuilder(stringColor) {
  return Container(
    width: 9,
    height: 9,
    margin: EdgeInsets.only(
      right: 4,
    ),
    decoration: BoxDecoration(
      color: Color(
        int.parse(
          stringColor,
        ),
      ),
      shape: BoxShape.circle,
    ),
  );
}
