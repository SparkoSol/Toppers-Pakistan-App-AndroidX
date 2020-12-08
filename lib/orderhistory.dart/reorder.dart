import 'package:flutter/material.dart';
import 'package:topperspakistan/models/order_model.dart';
import 'package:topperspakistan/models/sale-order-item_model.dart';
import 'package:topperspakistan/models/sale-order.dart';
import 'package:http/http.dart' as http;
import 'package:topperspakistan/services/sale-order_service.dart';

class ReOrder extends StatefulWidget {
  final SaleOrder order;
  final List<SaleOrderItem> orderItems;

  ReOrder({this.order, this.orderItems});

  @override
  _ReOrderState createState() => _ReOrderState();
}

class _ReOrderState extends State<ReOrder> {
  void reOrder() async {

    print("Inside Reorder");
    final _service = SaleOrderService();
    List<MyItem> items = [];
    for (SaleOrderItem item in widget.orderItems) {
      MyItem newItem = new MyItem();
      newItem.item = item;
      items.add(newItem);
    }

    var response = await http.get(
        Uri.encodeFull('https://api.toppers-mart.com/api/saleOrder/getInvoice'),
        headers: {"Accept": "application/json"});
    SaleOrder sale = new SaleOrder();
    sale.invoiceDate = DateTime.now().toString();
    sale.invoiceId = response.body;
    sale.customerId = widget.order.customerId;
    sale.addressId = widget.order.addressId;
    sale.branchId = widget.order.branchId;
    sale.paymentType = 'Cash';
    sale.amount = widget.order.amount;
    sale.origin = "App Order";
    sale.delivery = 1;
    sale.instructions = insController.text;
    sale.balanceDue = int.parse(widget.order.amount);
    sale.items = items;

    SaleOrder saleOrder = await _service.insert(sale);
    print("insertion was successfully");
    print(saleOrder.toJson());
    print("After New Order Model");
    print("Reorder Completed");

    _service.sendMail(saleOrder.id);

    for (var i = 0; i < 2; i++) {
      Navigator.pop(context);
    }
  }

  TextEditingController insController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RE-ORDER",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
            new IconButton(
            icon: new Image.asset('images/LogoTrans.png'),
            iconSize: 80.0,
            onPressed: null,
          ),
          ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
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
                "Your order will be in 30 to 45 mins.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Center(
            child: Text(
              "OrderID # " + widget.order.id.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: insController,
                decoration: InputDecoration(
                  hintText: "Additional Instructions",
                  border: InputBorder.none,
                ),
                maxLines: 5,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              "Are you sure to Place Order?",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 15,
              child: RaisedButton(
                color: Color(0xffcdaa44),
                onPressed: () {
                  reOrder();
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
      ),
    );
  }
}
