import 'package:flutter/material.dart';
import 'package:topperspakistan/models/order-item_model.dart';
import 'package:topperspakistan/models/product_model.dart';
import 'package:topperspakistan/models/unit_model.dart';
import 'package:topperspakistan/services/unit_service.dart';

import '../cart_list.dart';

class ConfirmOrder extends StatefulWidget {
  final _service = UnitService();
  final ProductModel product;

  ConfirmOrder({this.product});
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  var value = 1;
  int _incrementCounter() {
    setState(() {
      value++;
    });
    return value;
  }

  int _decrementCounter() {
    setState(() {
      if (value > 1) {
        value--;
      }
    });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UnitModel>>(
        future: widget._service.fetchAllById(widget.product.unitId),
        builder: (context, AsyncSnapshot<List<UnitModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return Column(
                  children: <Widget>[
                    Image.network(
                      "http://nabeel-pc:8000/images/products/" +
                          widget.product.image,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      splashColor: Colors.grey,
                      child: ListTile(
                        title: Text(
                          widget.product.quantity + " " + snapshot.data[i].name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        subtitle: Text("serving(s) " +
                            widget.product.serving +
                            " person(s)"),
                        trailing: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              "Rs . " + widget.product.unitPrice,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _decrementCounter();
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("$value"),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _incrementCounter();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 15,
                        child: RaisedButton(
                          color: Color(0xffcdaa44),
                          onPressed: () {
                            for (var orderItem in CartList.orderItems) {
                              if (orderItem.productId ==
                                  widget.product.id.toString()) {
                                orderItem.quantity = value;
                                Navigator.pop(context);
                                Navigator.pop(context);
                                return;
                              } else {
                                continue;
                              }
                            }
                            OrderItemModel orderItem = new OrderItemModel();
                            orderItem.productId = widget.product.id.toString();
                            orderItem.quantity = value;
                            orderItem.name = widget.product.name;
                            orderItem.restaurantId =
                                widget.product.restaurantId;
                            orderItem.categoryId = widget.product.categoryId;
                            orderItem.unit = snapshot.data[i].name;
                            orderItem.serving = widget.product.serving;
                            orderItem.unitPrice = widget.product.unitPrice;
                            orderItem.image = widget.product.image;
                            orderItem.weight = widget.product.quantity;
                            CartList.orderItems.add(orderItem);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("ADD TO MY BASKET",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
