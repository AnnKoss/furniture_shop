import 'package:flutter/material.dart';

import 'package:flutter_furniture_shop/data/server_data.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_gridview_card.dart';
import '../common/styles.dart';

class CatalogueScreen extends StatefulWidget {
  static const routeName = '/catalogue';
  @override
  @override
  _CatalogueScreenState createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  String categoriesDropdownValue = 'Диваны';
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
                  // DropdownButton<String>(
                  //   value: categoriesDropdownValue,
                  //   items: categoriesList
                  //       .map((categoryItem) => categoryItem.title)
                  //       .toList()
                  //       .map<DropdownMenuItem<String>>(
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
                  //     // ToDo: add content changing logic
                  //   },
                  // ),
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
                  //   // ToDo: rewrte filter
                  // ),
                  Text('''Категории                  Фильтр'''),
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
                  child:
                      Text(categoriesDropdownValue, style: acceptedFilterTitle),
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
                              categoriesDropdownValue,
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
              GridView.builder(
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
                  return GridViewCard(
                    catalogueItemsList[index].id,
                    catalogueItemsList[index].title,
                    catalogueItemsList[index].imageUrl,
                    catalogueItemsList[index].colorOptions,
                    catalogueItemsList[index].price,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: ,
    );
  }
}
