import 'dart:convert';

import 'package:topperspakistan/models/sale-order-item_model.dart';
import 'package:topperspakistan/services/_services.dart';
import 'package:http/http.dart' as http;

class SaleOrderItemService extends Service<SaleOrderItem> {
  @override
  SaleOrderItem parse(Map<String, dynamic> json) {
    return SaleOrderItem.fromJson(json);
  }

  Future<List<SaleOrderItem>> fetchAllOrderItemsByOrder(id) async {
    var response = await http.get(
        Uri.encodeFull(
            "$apiUrl/saleOrderItems/saleOrder/" + id.toString()),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }

  String get route => "order-item";
}
