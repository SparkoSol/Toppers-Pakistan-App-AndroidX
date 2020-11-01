import 'dart:convert';

import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/models/order-item_model.dart';
import 'package:topperspakistan/models/order_model.dart';
import 'package:topperspakistan/services/_services.dart';
import 'package:http/http.dart' as http;

class OrderService extends Service<OrderModel> {
  @override
  OrderModel parse(Map<String, dynamic> json) {
    return OrderModel.fromJson(json);
  }

  Future<List<OrderModel>> fetchAllOrderByCustomerId() async {
    print("ID Of logged customer => " + LocalData.getProfile().id.toString());
    var response = await http.get(
        Uri.encodeFull(
            "$apiUrl/customer-order/" + LocalData.currentCustomer.id.toString()),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body) as List;
    return data.map((item) => parse(item)).toList();
  }


  Future<void> sendMail(OrderModel order , List<OrderItemModel> orderItems) async{
    var data = {
      "order" : order.toJson(),
      "orderItems": orderItems.map((f) => f.toJson()).toList()
    };
    var jsonData = jsonEncode(data);
    print(jsonData);
    try {
      var response = await http.post(Uri.encodeFull("$apiUrl/orderConfirmation"),
          body: jsonData,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          });
      print(response.body);
    } catch (e) {
      print("Error=> "  + e.toString());
    }
  }

  String get route => "order";
}
