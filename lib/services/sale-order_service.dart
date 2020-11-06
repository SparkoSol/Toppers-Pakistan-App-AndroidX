import 'dart:convert';

import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/models/sale-order-item_model.dart';
import 'package:topperspakistan/models/sale-order.dart';
import 'package:topperspakistan/services/_services.dart';
import 'package:http/http.dart' as http;

class SaleOrderService extends Service<SaleOrder> {
  @override
  SaleOrder parse(Map<String, dynamic> json) {
    return SaleOrder.fromJson(json);
  }

  Future<List<SaleOrder>> fetchAllOrderByCustomerId() async {
    print('Get Orders');
    var response = await http.get(
        Uri.encodeFull("$apiUrl/saleOrder/customer/" +
            LocalData.currentCustomer.id.toString() +
            '/' +
            LocalData.branchId.id.toString()),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }

  Future<void> sendMail(id) async {
    try {
      var response = await http.get(
          Uri.encodeFull("$apiUrl/saleOrder/mail/" + id.toString()),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          });
      print(response.body);
    } catch (e) {
      print("Error=> " + e.toString());
    }
  }

  String get route => "saleOrder/store";
}
