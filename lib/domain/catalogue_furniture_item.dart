class CatalogueFurnitureItem {
  ///Single item with basic information.
  final String title;
  final int id;
  //if implemented with FireBase, will be taken from server side
  final String category;
  final String imageUrl;
  final int price;
  final List<ColorStringAndHex> colorOptions;
  final bool isFav;

  CatalogueFurnitureItem(
    this.title,
    this.id,
    this.category,
    this.imageUrl,
    this.price,
    this.colorOptions,
    this.isFav,
  );

  factory CatalogueFurnitureItem.fromJson(Map<String, dynamic> json) {
    return CatalogueFurnitureItem(
      json['title'] as String,
      json['id'] as int,
      json['category'] as String,
      json['imageUrl'] as String,
      json['price'] as int,
      json['colorOptions'] as List<ColorStringAndHex>,
      json['isFav'] as bool,
    );
  }

  

  Map<String, dynamic> toJson() {
    Map<String, String> coValue = {
      for (var co in colorOptions) co.title: co.hex
    };
    print('coValue: $coValue');
    return {
      'title': this.title,
      'id': this.id,
      'category': this.category,
      'imageUrl': this.imageUrl,
      'price': this.price,
      // 'colorOptions': {
      //   for (var co in colorOptions) co.title: co.hex
      // },
      // ToDo: correct colorOptions code

      'isFav': this.isFav,
    };
  }
}

class ColorStringAndHex {
  String title;
  String hex;

  ColorStringAndHex(
    this.title,
    this.hex,
  );
}
