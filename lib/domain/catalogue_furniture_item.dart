class CatalogueFurnitureItem {
  ///Single item with basic information.
  final String title;
  final int id;
  //if implemented with FireBase, will be taken from server side
  final String category;
  final String imageUrl;
  final int price;
  final Set<ColorStringAndHex> colorOptions;
  bool isFav;

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
      Set<ColorStringAndHex>.from(
        json['colorOptions'].map(
          (i) => ColorStringAndHex.fromJson(i),
        ),
      ),
      json['isFav'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    List colorOptions = this
        .colorOptions
        .map(
          (e) => e.toJson(),
        )
        .toList();
    return {
      'title': this.title,
      'id': this.id,
      'category': this.category,
      'imageUrl': this.imageUrl,
      'price': this.price,
      'colorOptions': colorOptions,
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

  @override
  bool operator ==(Object other) => other is ColorStringAndHex && other.title == title && other.hex == hex;

  @override
  int get hashCode => title.hashCode+hex.hashCode;

  factory ColorStringAndHex.fromJson(Map<String, dynamic> json) {
    return ColorStringAndHex(
      json['title'] as String,
      json['hex'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': '${this.title}',
      'hex': '${this.hex}',
    };
  }
}
