class DetailFurnitureItem {
  ///Single item with information for detailscreen.
  final int id;
  final String description;
  final List<String> reviews;
  final String delivery;

  DetailFurnitureItem(
    this.id,
    this.description,
    this.reviews,
    this.delivery,
  );

  factory DetailFurnitureItem.fromJson(Map<String, dynamic> json) {
    DetailFurnitureItem item = DetailFurnitureItem(
      json['id'] as int,
      json['description'] as String,
      List<String>.from(json['reviews']),
      json['delivery'] as String,
    );
    return item;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'description': this.description,
      'reviews': this.reviews,
      'delivery': this.delivery,
    };
  }
}
