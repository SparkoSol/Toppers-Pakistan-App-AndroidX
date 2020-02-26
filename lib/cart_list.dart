import 'dart:convert';

import 'package:topperspakistan/models/address_model.dart';
import 'package:topperspakistan/models/order-item_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CartList {
  static List<OrderItemModel> _orderItems = [];
  static AddressModel address;
  static String instruction;
  static int totalPrice;

  static List<OrderItemModel> getItems() {
    return _orderItems;
  }

  static void emptyCartList(){
    address = null;
    instruction = "";
    totalPrice = 0;
    _orderItems = [];
    writeCartData();
  }

  static void addToCart(orderItem) {
    _orderItems.add(orderItem);
    writeCartData();
  }

  static void removeFromCart(int index) {
    _orderItems.removeAt(index);
    writeCartData();
  }

  static readCartData() async {
    final file =
        File((await getApplicationDocumentsDirectory()).path + '/cart.json');
    try {
      final data = jsonDecode(await file.readAsString());
      _orderItems = data['cart']
          .map<OrderItemModel>((item) => OrderItemModel.fromJson(item))
          .toList();
    } catch (e) {
      await file.writeAsString('');
    }
  }

  static writeCartData() async {
    final file =
        File((await getApplicationDocumentsDirectory()).path + '/cart.json');
    await file.writeAsString(jsonEncode({
      'cart': _orderItems.map((item) => item.toJson()).toList(),
    }));
  }
}
