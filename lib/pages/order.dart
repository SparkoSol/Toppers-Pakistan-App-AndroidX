import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:topperspakistan/models/category_model.dart';
import 'package:topperspakistan/models/product_model.dart';
import 'package:topperspakistan/models/subCategories_model.dart';
import 'package:topperspakistan/pages/model.dart';
import 'package:topperspakistan/pages/order_confirm.dart';

class Order extends StatefulWidget {
  final SubCategoryModel subCategoryModel;

  Order({this.subCategoryModel});

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products",
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
      ),      // backgroundColor: Colors.black,
      backgroundColor: Colors.white,
      body: FutureBuilder<List<ProductModel>>(
          future: widget.subCategoryModel.fetchProduct(widget.subCategoryModel.id),
          builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("No Connection");
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text("No Products Found"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmOrder(
                                  product: snapshot.data[i],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(3, 10, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        "http://toppers-pakistan.toppers-mart.com/images/products/" +
                                            snapshot.data[i].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[i].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Price: " +
                                                snapshot.data[i].unitPrice +
                                                " Rs",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    );
                  }
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
