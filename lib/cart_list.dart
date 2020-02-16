import 'package:topperspakistan/models/address_model.dart';
import 'package:topperspakistan/models/order-item_model.dart';

class CartList {
  static List<OrderItemModel> orderItems = new  List();
  static AddressModel address;
  static String instruction;
  static int totalPrice;
}