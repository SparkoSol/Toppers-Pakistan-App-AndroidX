import '_model.dart';

class ProductModel extends Model {
  final String name;
  final String restaurantId;
  final String categoryId;
  final String unitId;
  final String quantity;
  final String serving;
  final String unitPrice;
  final String image;

  ProductModel(
      {int id,
      this.name,
      this.restaurantId,
      this.categoryId,
      this.unitId,
      this.quantity,
      this.serving,
      this.unitPrice,
      this.image})
      : super(id: id);

  ProductModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['name'],
            restaurantId: json['restautrant_id'].toString(),
            categoryId: json['category_id'].toString(),
            unitId: json['unit_id'].toString(),
            quantity: json['quantity'].toString(),
            serving: json['serving'].toString(),
            unitPrice: json['unit_price'].toString(),
            image: json['image']);

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'restaurant_id': restaurantId,
        'category_id': categoryId,
        'unit_id': unitId,
        'quantity': quantity,
        'serving': serving,
        'unit_price': unitPrice,
        'image': image
      };
}
