import 'dart:convert';

import 'package:topperspakistan/models/address_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:topperspakistan/models/sale-order-item_model.dart';

class CartList {
  static List<SaleOrderItem> _orderItems = [];
  static AddressModel address;
  static String instruction;
  static int totalPrice;

  static List<SaleOrderItem> getItems() {
    for(SaleOrderItem item in _orderItems) {
      print(item.toJson());
    }
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
    print(orderItem);
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
          .map<SaleOrderItem>((item) => SaleOrderItem.fromJson(item))
          .toList();
    } catch (e) {
      print("error reading data");
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
