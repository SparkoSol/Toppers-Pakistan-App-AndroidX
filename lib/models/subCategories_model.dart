import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:topperspakistan/models/product_model.dart';

import '_model.dart';

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

  Future<List<ProductModel>> fetchProduct(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://toppers-pakistan.toppers-mart.com/api/subCategory/$id/products"),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }

  ProductModel parse(Map<String, dynamic> json) {
    return ProductModel.fromJson(json);
  }
}
