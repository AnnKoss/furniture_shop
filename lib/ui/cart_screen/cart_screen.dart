import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/domain/cart_item.dart';
import 'package:flutter_furniture_shop/ui/common/bottom_navigation_bar.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_bloc.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_item_card.dart';
import 'package:flutter_furniture_shop/ui/common/styles.dart';
import 'package:flutter_furniture_shop/ui/common/default_alert_dialog.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    context.read<CartBloc>().add(
          GetCartItemsEvent(),
        );
  }

  bool isCartEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (
            context,
            state,
          ) {
            if (state is CartErrorState) {
              return DefaultAlertDialog(state.errorMessage);
            }
            if (state is CartLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoadedState) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: state.items.isNotEmpty
                    ? Column(
                        children: [
                          Center(
                            child: Text(
                              'Корзина',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FlatButton.icon(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  for (CartItem cartitem in state.items) {
                                    context.read<CartBloc>().add(
                                          ChangeIsCheckedEvent(
                                              cartitem.item.id),
                                        );
                                  }
                                },
                                icon: Icon(Icons.check),
                                label: Text('Выбрать все'),
                              ),
                              SizedBox(width: 30),
                              FlatButton.icon(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  state.items
                                      .where((item) => item.isChecked)
                                      .forEach((element) {
                                    context.read<CartBloc>().add(
                                          RemoveItemFromCartEvent(
                                            element.item,
                                            true,
                                          ),
                                        );
                                  });
                                },
                                icon: Icon(Icons.delete_forever),
                                label: Text('Удалить выбранные'),
                              ),
                            ],
                          ),
                          ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CartItemCard(
                                state.items[index],
                              );
                            },
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Итого: ${state.totalSum.toString()} Руб',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Корзина',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'В корзине пока ничего нет',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
              );
            }
          },
        ),
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (
          context,
          state,
        ) {
          if (state is CartLoadedState) {
            return state.items.isNotEmpty
                ? Container(
                    height: 56,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        //ToDo: implement bloc.add(CartCheckoutEvent). If Cart.isEmpty should be disabled
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      label: Text(
                        'Перейти к оформлению заказа',
                        style: fabText,
                      ),
                    ),
                  )
                : SizedBox(height: 0);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomBottomNavigationBar(2),
    );
  }
}
