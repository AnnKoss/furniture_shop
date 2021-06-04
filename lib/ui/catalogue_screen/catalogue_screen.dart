import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/data/server_data.dart';
import 'package:flutter_furniture_shop/domain/category_item.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_bloc.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_gridview_card.dart';
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

    context.read<FurnitureItemsBloc>().add(
          FetchAllFurnitureItemsEvent(),
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
          child: Column(
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
                      value: categoriesDropdownValue.title,
                      items: categoriesList
                          .map(
                            (categoryItem) => categoryItem.title,
                          )
                          .toList()
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            onTap: () {
                              // context.read<FurnitureItemsBloc>().add(
                              //       FetchFurnitureCategoryItemsEvent(value),
                              //     );
                              // ToDo: fix filter
                            },
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          categoriesDropdownValue = categoriesList.firstWhere(
                            (element) => element.title == value,
                          );
                        });
                        // ToDo: add content changing logic
                      },
                      style: filtersText,
                      icon: Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                  // DropdownButton<String>(
                  //   value: categoriesDropdownValue,
                  //   items: filterList.map<DropdownMenuItem<String>>(
                  //     (String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     },
                  //   ).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       categoriesDropdownValue = value;
                  //     });
                  //   },
                  // ),
                  // ToDo: rewrte filter
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
              Container(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/sofas-category-image.png',
                      ),
                      // ToDo: image shoud change according to the chosen category
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color.fromRGBO(160, 163, 189, 0.9),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              categoriesDropdownValue.title,
                              style: categoryTitleOnImage,
                            ),
                            Text(
                              'бесплатная доставка',
                              style: categoryTextOnImage,
                            ),
                            //Todo: implement logic
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<FurnitureItemsBloc, FurnitureItemsState>(
                builder: (
                  context,
                  state,
                ) {
                  //ToDo: implement error state
                  if (state is FurnitureItemsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FurnitureItemsLoadedState) {
                    return GridView.builder(
                      itemCount: catalogueItemsList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.9,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GridViewCard(state.items[index]);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(0),
    );
  }
}

// class CategoriesFilter {
//   final String title;
//   final String category;
//   CategoriesFilter(this.title, this.category,);
// }
