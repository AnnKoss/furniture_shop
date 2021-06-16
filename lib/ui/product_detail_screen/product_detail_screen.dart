﻿import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/ui/product_detail_screen/detail_screen_bloc.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_bloc.dart';
import 'package:flutter_furniture_shop/data/server_data.dart';
import 'package:flutter_furniture_shop/domain/detail_furniture_item.dart';
import 'package:flutter_furniture_shop/ui/common/styles.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_gridview_card.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments =
        ModalRoute.of(context).settings.arguments as ScreenArguments;

    context.read<DetailScreenItemBloc>().add(
          FetchDetailScreenItemEvent(arguments.item.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as ScreenArguments;

    // final DetailFurnitureItem detailFurnitureItem =
    //     detailScreenItemsList.firstWhere(
    //   (element) => element.id == arguments.item.id,
    // );
    //ToDo: implement error handling

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 325,
                // ToDo: if counted dinamically, correct height
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffEFF0F6),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.asset(arguments.item.imageUrl),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    arguments.item.title,
                    style: productDetailScreenTitle,
                  ),
                  Text(
                    '${arguments.item.price.toString()} Руб',
                    style: productDetailScreenPrice,
                  )
                ],
              ),
              SizedBox(height: 36),
              DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Column(
                  children: [
                    Container(
                      child: TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: const Color(0xffA0A3BD),
                        labelStyle: productDetailScreenTabLabel,
                        tabs: [
                          Tab(
                            text: 'Описание',
                          ),
                          Tab(
                            text: 'Отзывы',
                          ),
                          Tab(
                            text: 'Доставка',
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<DetailScreenItemBloc, DetailScreenItemState>(
                      builder: (
                        context,
                        state,
                      ) {
                        //ToDo: implement error state
                        if (state is DetailScreenItemLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is DetailScreenItemLoadedState) {
                          return Container(
                            height: 300,
                            padding: EdgeInsets.only(top: 33),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    state.item.description,
                                    style: productDetailScreenTabText,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: state.item.reviews.map(
                                      (element) {
                                        return Container(
                                          child: Text(
                                            element,
                                            style: productDetailScreenTabText,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    state.item.delivery,
                                    style: productDetailScreenTabText,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 56,
        width: 270,
        child: FloatingActionButton.extended(
          onPressed: () {
            context.read<CartBloc>().add(
                  AddItemToCartEvent(
                    arguments.item,
                  ),
                );
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
          //ToDo: What should happen on button pressed in the UI? 
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          label: Row(
            children: [
              Text(
                'Добавить',
                style: fabText,
              ),
              SizedBox(width: 10),
              Icon(
                Icons.shopping_bag_outlined,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
