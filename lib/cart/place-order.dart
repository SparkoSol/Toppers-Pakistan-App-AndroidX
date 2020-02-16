import 'package:flutter/material.dart';
import 'package:topperspakistan/cart_list.dart';
import 'package:topperspakistan/drawer/account/order_history.dart';
import 'package:topperspakistan/models/branch_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/models/order_model.dart';
import 'package:topperspakistan/services/branch_service.dart';
import 'package:topperspakistan/services/order-item_service.dart';
import 'package:topperspakistan/services/order_service.dart';
import 'package:topperspakistan/simple-future-builder.dart';

import '../round-drop-down-button.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  int deliveryCharges = 80;
  int taxCharges = 0;
  final _branchService = BranchService();

  Future<List<BranchModel>> branchListFuture;
  List<BranchModel> branchList;
  BranchModel selectedBranch;
  
  @override
  void initState() {
    super.initState();
    branchListFuture = _branchService.fetchAll();
     branchListFuture.then((data) {
      branchList = data;
    });
    }

  void _storeOrder() async {
    final _service = OrderService();
    final _serviceOrderItem = OrderItemService();

    int totalPrice = CartList.totalPrice + deliveryCharges + taxCharges;

    OrderModel order = new OrderModel();
    order.customerId = LocalData.currentCustomer.id.toString();
    order.addressId = CartList.address.id.toString();
    order.totatlPrice = totalPrice;
    order.instruction = CartList.instruction;
    order.branchId = selectedBranch.id.toString();

    print(order.customerId);
    OrderModel newOrder = await _service.insert(order);
    print(newOrder.id);

    for (var orderItem in CartList.orderItems) {
      orderItem.orderId = newOrder.id.toString();

      await _serviceOrderItem.insert(orderItem);
    }

    CartList.orderItems = new List();
    CartList.address = null;
    CartList.instruction = null;
    CartList.totalPrice = null;

    for (var i = 0; i < 5; i++) {
      Navigator.pop(context);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderHistory()));
  }

  void _placeorder(String title,String content) {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
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
                  if(title != 'Error'){
                  _storeOrder();
                  }else{
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
          title: Text("Place Order"),
          centerTitle: true,
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
                    "Your order will be delivered tommorrow between 12:00 pm to 04:00 pm .",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
                    trailing: Text("Rs." + (deliveryCharges).toString()),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 0,
                  ),
                  ListTile(
                    leading: Text("Total"),
                    trailing: Text(
                      "Rs. " +
                          (CartList.totalPrice + deliveryCharges + taxCharges)
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
                        SimpleFutureBuilder.simpler(
              context: context,
              future: branchListFuture,
              builder: (AsyncSnapshot<List<BranchModel>> snapshot) {
                
                return RoundDropDownButton<BranchModel>(
                  hint: Text('Restaurant Branch'),
                  items: branchList.map((branch) {
                    return DropdownMenuItem(
                      child: Text(branch.name),
                      value: branch,
                    );
                  }).toList(),
                  value: selectedBranch,
                  onChanged: (val) => setState(() {
                    selectedBranch = val;
                  }),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                child: RaisedButton(
                  color: Color(0xffCE862A),
                  onPressed: () {
                    if(selectedBranch == null){
                    _placeorder('Error','Please Select Restaurant Branch.');
                    }else{
                    _placeorder('Sucess','Your Order is Placed.');
                    }
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
