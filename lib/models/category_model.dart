import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:topperspakistan/models/subCategories_model.dart';

import '_model.dart';

class CategoryModel extends Model {
  final String name;
  final String image;

  CategoryModel({int id, this.name, this.image}) : super(id: id);

  CategoryModel.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], name: json['name'], image: json['image']);

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
      };

  Future<List<SubCategoryModel>> fetchSubCategory(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "http://192.168.100.23:8000/api/category/$id/subCategories"),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parseSub(item)).toList();
  }

  SubCategoryModel parseSub(Map<String, dynamic> json) {
    return SubCategoryModel.fromJson(json);
  }
}
