import 'dart:convert';

import 'package:topperspakistan/models/product_model.dart';
import 'package:topperspakistan/services/_services.dart';
import 'package:http/http.dart' as http;

class ProductService extends Service<ProductModel> {
  @override
  ProductModel parse(Map<String, dynamic> json) {
    return ProductModel.fromJson(json);
  }

  Future<ProductModel> fetchAllProductsByItem(id) async {
    var response = await http.get(
        Uri.encodeFull("$apiUrl/order-item-product/" + id.toString()),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body);
    return parse(data);
  }

  String get route => "product";
}
