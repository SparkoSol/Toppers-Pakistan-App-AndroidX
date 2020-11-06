import 'package:topperspakistan/models/_model.dart';
import 'package:topperspakistan/models/item.dart';
import 'package:topperspakistan/models/variant_model.dart';

class SaleOrderItem extends Model{
  int amount;
  String createdAt;
  int id;
  int itemId;
  String price;
  Item product;
  String qty;
  int saleOrderId;
  String updatedAt;
  Variant variant;
  int variantId;
  List<Variant> variants;

  SaleOrderItem(
      {this.amount,
        this.createdAt,
        this.id,
        this.itemId,
        this.price,
        this.product,
        this.qty,
        this.saleOrderId,
        this.updatedAt,
        this.variant,
        this.variantId,
        this.variants});

  SaleOrderItem.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createdAt = json['created_at'];
    id = json['id'];
    itemId = json['item_id'];
    price = json['price'];
    product =
    json['product'] != null ? new Item.fromJson(json['product']) : null;
    qty = json['qty'];
    saleOrderId = json['sale_order_id'];
    updatedAt = json['updated_at'];
    variant =
    json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
    variantId = json['variant_id'];
    if (json['variants'] != null) {
      variants = new List<Variant>();
      json['variants'].forEach((v) {
        variants.add(new Variant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['price'] = this.price;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['qty'] = this.qty;
    data['sale_order_id'] = this.saleOrderId;
    data['updated_at'] = this.updatedAt;
    if (this.variant != null) {
      data['variant'] = this.variant.toJson();
    } else {
      data['variant'] = null;
    }
    data['variant_id'] = this.variantId;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}