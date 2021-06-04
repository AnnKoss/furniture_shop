import 'package:flutter/material.dart';
import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';

class CartItemCard extends StatefulWidget {
  final CatalogueFurnitureItem item;
  CartItemCard(this.item);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).primaryColor,
                        value: isChecked,
                        onChanged: (bool value) {
                          setState(
                            () {
                              isChecked = value;
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.item.title),
                        // Text('Beige'),
                        //ToDo where is color option chosen in UI?
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 52),
                Text('${widget.item.price} Руб'),
                //ToDo: Should price increase when quantity raises?
                SizedBox(height: 7),
                Row(
                  children: [
                    _quantityBarTileBuilder(context, '-'),
                    _quantityBarTileBuilder(context, '1'),
                    //ToDo: implement logic
                    _quantityBarTileBuilder(context, '+'),
                    Container(),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      color: const Color(0xffEFF0F6),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_forever,
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 155,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.asset(widget.item.imageUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _quantityBarTileBuilder(
  BuildContext context,
  String text,
) {
  return Container(
    width: 32,
    height: 32,
    color: const Color(0xffEFF0F6),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
  );
}
