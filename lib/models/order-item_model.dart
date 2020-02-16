import '_model.dart';

class OrderItemModel extends Model {
  String orderId;
  String productId;
  int quantity;
  String weight;
  String name;
  String restaurantId;
  String categoryId;
  String unit;
  String serving;
  String unitPrice;
  String image;

  OrderItemModel(
      {int id,
      this.weight,
      this.orderId,
      this.productId,
      this.quantity,
      this.name,
      this.restaurantId,
      this.categoryId,
      this.unit,
      this.unitPrice,
      this.serving,
      this.image})
      : super(id: id);

  OrderItemModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            orderId: json['order_id'].toString(),
            productId: json['product_id'].toString(),
            quantity: json['quantity']);

  @override
  Map<String, dynamic> toJson() =>
      {'order_id': orderId, 'product_id': productId, 'quantity': quantity};
}
