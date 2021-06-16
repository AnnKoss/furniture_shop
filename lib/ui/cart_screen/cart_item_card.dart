import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_furniture_shop/domain/cart_item.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_bloc.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;
  CartItemCard(
    this.cartItem,
  );

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
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
                        value: widget.cartItem.isChecked,
                        onChanged: (bool value) {
                          context.read<CartBloc>().add(
                                ChangeIsCheckedEvent(widget.cartItem.item.id),
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
                        Text(widget.cartItem.item.title),
                        // Text('Beige'),
                        //ToDo where is color option chosen in UI?
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 52),
                Text('${widget.cartItem.item.price} Руб'),
                //ToDo: Should price increase when quantity raises?
                SizedBox(height: 7),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<CartBloc>().add(
                              RemoveItemFromCartEvent(
                                widget.cartItem.item,
                                false,
                              ),
                            );
                      },
                      child: _quantityBarTileBuilder(context, '-'),
                    ),
                    //ToDo: Should we ask whether to delete card if removing the last item?
                    _quantityBarTileBuilder(
                      context,
                      widget.cartItem.quantity.toString(),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CartBloc>().add(
                              AddItemToCartEvent(widget.cartItem.item),
                            );
                      },
                      child: _quantityBarTileBuilder(context, '+'),
                    ),
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
                          onPressed: () {
                            context.read<CartBloc>().add(
                                  RemoveItemFromCartEvent(
                                    widget.cartItem.item,
                                    true,
                                  ),
                                );
                          },
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
                child: Image.asset(
                  widget.cartItem.item.imageUrl,
                  width: 155,
                  height: 130,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _quantityBarTileBuilder(
  final BuildContext context,
  final String text,
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
