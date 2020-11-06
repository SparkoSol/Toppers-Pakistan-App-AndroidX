import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/models/product_model.dart';

import '_model.dart';
import 'item_model.dart';

class SubCategoryModel extends Model {
  final String name;
  final String categoryId;
  final String image;

  SubCategoryModel({int id, this.categoryId, this.name, this.image})
      : super(id: id);

  SubCategoryModel.fromJson(Map<String, dynamic> json)
      : this(id: json['id'],categoryId: json['category_id'].toString(), name: json['name'], image: json['image']);

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'category_id':categoryId,
        'image': image,
      };

  Future<List<ItemModel>> fetchProduct(id) async {
    var response;
    if (LocalData.branchId != null) {
      response = await http.get(
          Uri.encodeFull(
              "http://192.168.100.23:8000/api/subCategory/$id/product/available/" + LocalData.branchId.id.toString()),
          headers: {"Accept": "application/json"});
    } else {
      print('inside fetch product');
      response = await http.get(
          Uri.encodeFull(
              "http://192.168.100.23:8000/api/subCategory/$id/product/available/null"),
          headers: {"Accept": "application/json"});
    }
    print(response);
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }

  ItemModel parse(Map<String, dynamic> json) {
    return ItemModel.fromJson(json);
  }
}
