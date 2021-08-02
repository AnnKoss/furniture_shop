import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/server_data.dart';
import 'package:flutter_furniture_shop/domain/category_item.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_bloc.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_item_card.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_screen_filters_popup.dart';
import 'package:flutter_furniture_shop/ui/common/default_alert_dialog.dart';
import '../common/styles.dart';
import 'package:flutter_furniture_shop/ui/common/bottom_navigation_bar.dart';

class CatalogueScreen extends StatefulWidget {
  static const routeName = '/catalogue';
  @override
  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  CategoryItem categoriesDropdownValue = categoriesList[0];

  @override
  void initState() {
    super.initState();

    context.read<CatalogueItemsBloc>().add(
          FetchAllCatalogueItemsEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<CatalogueItemsBloc, CatalogueItemsState>(
            builder: (
              context,
              state,
            ) {
              if (state is CatalogueItemsErrorState) {
                return DefaultAlertDialog(state.errorMessage);
              }
              if (state is CatalogueItemsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CatalogueItemsLoadedState) {
                return Column(
                  children: [
                    Center(
                      child: Text(
                        'Каталог',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: <Widget>[
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Row(
                              children: [
                                Text(
                                  'Категории',
                                  style: filtersText,
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                            items: categoriesList.map<DropdownMenuItem<String>>(
                              (CategoryItem value) {
                                return DropdownMenuItem<String>(
                                  value: value.title,
                                  child: Text(value.title),
                                  onTap: () {
                                    context.read<CatalogueItemsBloc>().add(
                                          FetchCatalogueCategoryItemsEvent(
                                              value.category),
                                        );
                                  },
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                categoriesDropdownValue =
                                    categoriesList.firstWhere(
                                  (element) => element.title == value,
                                );
                              });
                            },
                            style: filtersText,
                            iconSize: 0,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        FlatButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FilterPopup(state.filter);
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'Фильтр',
                                style: filtersText,
                              ),
                              Icon(Icons.filter_list),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 12,
                        ),
                        decoration: const BoxDecoration(
                          color: const Color(0xffDADEFA),
                          borderRadius: BorderRadius.all(
                            Radius.circular(39),
                          ),
                        ),
                        child: Text(categoriesDropdownValue.title,
                            style: acceptedFilterTitle),
                      ),
                    ),
                    SizedBox(height: 18),
                    state.filteredItems.isNotEmpty
                        ? Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/sofas-category-image.png',
                                      ),
                                      // ToDo: image shoud change according to the chosen category. Currently no images provided.
                                      Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              const Color.fromRGBO(
                                                  160, 163, 189, 0.9),
                                              const Color(0xffffff),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 21,
                                          left: 8,
                                          right: 8,
                                          bottom: 8,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              categoriesDropdownValue.title,
                                              style: categoryTitleOnImage,
                                            ),
                                            Text(
                                              'бесплатная доставка',
                                              style: categoryTextOnImage,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              GridView.builder(
                                itemCount: state.filteredItems.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.85,
                                ),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return GridViewCard(
                                      state.filteredItems[index]);
                                },
                              )
                            ],
                          )
                        : Center(
                            child: Text('В этой категории нет товаров'),
                          )
                  ],
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(0),
    );
  }
}
