import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_bloc.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_screen.dart';
import 'package:flutter_furniture_shop/ui/common/fav_mark.dart';

class FavoriteItem extends StatefulWidget {
  final CatalogueFurnitureItem item;
  FavoriteItem(this.item);

  @override
  _FavoriteItemState createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.title),
                // SizedBox(height: 52),
                Text(
                  '${widget.item.price} Руб',
                ),
                SizedBox(height: 30),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Добавить',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                  onPressed: () {
                    context.read<CartBloc>().add(
                          AddItemToCartEvent(
                            widget.item,
                          ),
                        );
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            Stack(children: [
              Positioned(
                top: 0,
                right: 0,
                child: FavoriteMark(
                  24,
                  24,
                  0,
                  20,
                  widget.item.isFav,
                  () {
                    // context.read<DetailScreenItemBloc>().add(
                    //       ToggleIsDetailFavouriteEvent(arguments.item.id),
                    //     );
                  },
                ),
              ),
              Container(
                width: 155,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.asset(
                    widget.item.imageUrl,
                    width: 155,
                    height: 130,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
