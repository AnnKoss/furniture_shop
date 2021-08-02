import 'package:flutter/material.dart';

class FavoriteMark extends StatefulWidget {
  final double width;
  final double height;
  final double padding;
  // final double circleSize;
  final double iconSize;
  final bool isFavCondition;
  final void Function() onTap;
  FavoriteMark(
    this.width,
    this.height,
    this.padding,
    // this.circleSize,
    this.iconSize,
    this.isFavCondition,
    this.onTap,
  );
  @override
  _FavoriteMarkState createState() => _FavoriteMarkState();
}

class _FavoriteMarkState extends State<FavoriteMark> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(widget.padding),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color(0xffDADEFA),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          margin: EdgeInsets.all(widget.padding),
          child: GestureDetector(
            child: widget.isFavCondition
                ? Icon(
                    Icons.favorite_outlined,
                    color: Colors.red[400],
                    size: widget.iconSize,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: widget.iconSize,
                  ),
            onTap: widget.onTap,
          ),
        ),
      ],
    );
  }
}
