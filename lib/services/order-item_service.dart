import 'dart:convert';

import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/models/order-item_model.dart';
import 'package:topperspakistan/models/product_model.dart';
import 'package:topperspakistan/services/_services.dart';
import 'package:http/http.dart' as http;

class OrderItemService extends Service<OrderItemModel> {
  @override
  OrderItemModel parse(Map<String, dynamic> json) {
    return OrderItemModel.fromJson(json);
  }

  Future<List<OrderItemModel>> fetchAllOrderItemsByOrder(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "$apiUrl/order-items/" + id.toString()),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }

  String get route => "order-item";
}
