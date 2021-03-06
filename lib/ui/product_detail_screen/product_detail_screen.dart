import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_furniture_shop/ui/common/default_alert_dialog.dart';
import 'package:flutter_furniture_shop/ui/common/fav_mark.dart';

import 'package:flutter_furniture_shop/ui/product_detail_screen/product_detail_bloc.dart';
import 'package:flutter_furniture_shop/ui/cart_screen/cart_bloc.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_bloc.dart';
import 'package:flutter_furniture_shop/ui/common/styles.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_item_card.dart';
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
          FetchDetailScreenItemEvent(
            arguments.item.id,
            arguments.item.isFav,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<DetailScreenItemBloc, DetailScreenItemState>(
            builder: (
              context,
              state,
            ) {
              if (state is DetailScreenItemErrorState) {
                return DefaultAlertDialog(state.errorMessage);
              }
              if (state is DetailScreenItemLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DetailScreenItemLoadedState) {
                return Column(
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: FavoriteMark(
                              32,
                              32,
                              8,
                              26,
                              state.isFav,
                              () {
                                context.read<DetailScreenItemBloc>().add(
                                      ToggleIsDetailFavouriteEvent(
                                          arguments.item.id),
                                    );
                              },
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Image.asset(arguments.item.imageUrl),
                          ),
                        ],
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
                      child: Column(children: [
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
                        Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                      ]),
                    ),
                  ],
                );
              }
            },
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
