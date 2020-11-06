import '_model.dart';
import 'item.dart';
import 'variant_model.dart';

class ItemModel extends Model {
  Item item;
  List<Variant> variants;
  List<MyImage> images;

  ItemModel({this.item, this.variants, this.images});

  ItemModel.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    if (json['variants'] != null) {
      variants = new List<Variant>();
      json['variants'].forEach((v) {
        variants.add(new Variant.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<MyImage>();
      json['images'].forEach((v) {
        images.add(new MyImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyImage {
  int id;
  String name;
  int itemId;
  String createdAt;
  String updatedAt;

  MyImage({this.id, this.name, this.itemId, this.createdAt, this.updatedAt});

  MyImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    itemId = json['item_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['item_id'] = this.itemId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
