import 'package:flutter/material.dart';
import 'package:topperspakistan/cart/dialog.dart';
import 'package:topperspakistan/cart_list.dart';
import 'package:topperspakistan/drawer/account/order_history.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/models/sale-order-item_model.dart';
import 'package:topperspakistan/models/sale-order.dart';
import 'package:topperspakistan/pages/loading.dart';
import 'package:topperspakistan/services/sale-order_service.dart';
import 'package:http/http.dart' as http;

import '../round-drop-down-button.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  int taxCharges = 0;

  @override
  void initState() {
    super.initState();
  }

  void _storeOrder() async {
    final _service = SaleOrderService();
    int totalPrice = 0;
    List<MyItem> items = [];
    for (SaleOrderItem item in CartList.getItems()) {
      totalPrice += item.amount;
      MyItem newItem = new MyItem();
      newItem.item = item;
      items.add(newItem);
    }
    totalPrice = totalPrice + LocalData.branchId.delivery + taxCharges;

    var response = await http.get(
        Uri.encodeFull('https://api.toppers-mart.com/api/saleOrder/getInvoice'),
        headers: {"Accept": "application/json"});
    SaleOrder sale = new SaleOrder();
    sale.invoiceDate = DateTime.now().toString();
    sale.invoiceId = response.body;
    sale.customerId = LocalData.currentCustomer.id;
    sale.addressId = CartList.address.id;
    sale.branchId = LocalData.branchId.id;
    sale.paymentType = 'Cash';
    sale.amount = totalPrice.toString();
    sale.origin = "App Order";
    sale.delivery = 1;
    sale.instructions = CartList.instruction;
    sale.balanceDue = totalPrice;
    sale.items = items;
    sale.deliveryFee = LocalData.branchId.delivery;
    

    SaleOrder saleOrder = await _service.insert(sale);
    print("insertion was succesfuly");
    print(saleOrder.toJson());
    _service.sendMail(saleOrder.id);

    CartList.emptyCartList();
    CartList.address = null;
    CartList.instruction = null;
    CartList.totalPrice = null;
    Navigator.pop(context);
    _placeOrder('Success', 'Your Order is Placed.');
  }

  void _placeOrder(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: Text(
              content,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  if (title != 'Error') {
                    // _storeOrder();
                    for (var i = 0; i < 5; i++) {
                      Navigator.pop(context);
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderHistory()));
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Place Order",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
              icon: new Image.asset('images/LogoTrans.png'),
              iconSize: 80.0,
              onPressed: null,
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Color(0xffCE862A),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Delivery Time",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              )),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color(0xffbc282b),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your order will be delivered within 30 to 45 minutes.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Text("Sub Total"),
                    trailing: Text("Rs. " + CartList.totalPrice.toString()),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 0,
                  ),
                  ListTile(
                    leading: Text("Tax (0%) "),
                    trailing: Text("Rs. $taxCharges"),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 0,
                  ),
                  ListTile(
                    leading: Text("Delivery Charges"),
                    trailing: Text("Rs." + (LocalData.branchId.delivery).toString()),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 0,
                  ),
                  ListTile(
                    leading: Text("Total"),
                    trailing: Text(
                      "Rs. " +
                          (CartList.totalPrice + LocalData.branchId.delivery + taxCharges)
                              .toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                child: RaisedButton(
                  color: Color(0xffCE862A),
                  onPressed: () {
                    openLoadingDialog(context, "Placing Order");
                    // _placeorder('Success', 'Your Order is Placed.');
                    _storeOrder();
                  },
                  child: Text("Place Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ));
  }
}
