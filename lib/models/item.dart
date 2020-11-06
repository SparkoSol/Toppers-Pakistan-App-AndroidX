import 'package:topperspakistan/models/_model.dart';
import 'package:topperspakistan/models/unit.dart';

class Item extends Model {
  int id;
  String name;
  String description;
  int restaurantId;
  int subCategoryId;
  int branchId;
  int unitId;
  int salePrice;
  int purchasePrice;
  int stock;
  int stockValue;
  String createdAt;
  String updatedAt;
  Unit unit;

  Item(
      {this.id,
        this.name,
        this.description,
        this.restaurantId,
        this.subCategoryId,
        this.branchId,
        this.unitId,
        this.salePrice,
        this.purchasePrice,
        this.stock,
        this.stockValue,
        this.createdAt,
        this.updatedAt,
        this.unit});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    restaurantId = json['restaurant_id'];
    subCategoryId = json['subCategory_id'];
    branchId = json['branch_id'];
    unitId = json['unit_id'];
    salePrice = json['sale_price'];
    purchasePrice = json['purchase_price'];
    stock = json['stock'];
    stockValue = json['stock_value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['restaurant_id'] = this.restaurantId;
    data['subCategory_id'] = this.subCategoryId;
    data['branch_id'] = this.branchId;
    data['unit_id'] = this.unitId;
    data['sale_price'] = this.salePrice;
    data['purchase_price'] = this.purchasePrice;
    data['stock'] = this.stock;
    data['stock_value'] = this.stockValue;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.unit != null) {
      data['unit'] = this.unit.toJson();
    }
    return data;
  }
}