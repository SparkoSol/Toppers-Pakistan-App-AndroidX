import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:topperspakistan/cart/cart.dart';
import 'package:topperspakistan/models/item_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/models/option_model.dart';
import 'package:topperspakistan/models/sale-order-item_model.dart';
import 'package:topperspakistan/pages/signin.dart';
import 'package:topperspakistan/services/option_service.dart';

import '../cart_list.dart';

class ConfirmOrder extends StatefulWidget {
  final ItemModel item;

  ConfirmOrder({this.item});
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  List<OptionModel> options = [];
  List<DropdownButton> dropdowns = [];
  SaleOrderItem saleOrderItem;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _service = OptionService();
  var value = 1;
  bool match = false;
  bool nomatch = false;
  Map<int, dynamic> _values = {};
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

  initiateVariants() async {
    options = await _service.fetchAllOptions(widget.item.item.id);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initiateVariants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.item.item.name,
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
      body: SingleChildScrollView(
        child: Column(children: [
          widget.item.images.isNotEmpty
              ? CarouselSlider(
                  height: 200,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  reverse: false,
                  enableInfiniteScroll: false,
                  autoPlayInterval: Duration(seconds: 5),
                  pauseAutoPlayOnTouch: Duration(seconds: 5),
                  scrollDirection: Axis.horizontal,
                  items: widget.item.images.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.network(
                            "http://192.168.100.23:8000/images/items/" +
                                imgUrl.name,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : Image.asset('images/LogoTrans.png'),
          SizedBox(height: 10),
          Text(
            widget.item.item.name,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(
            widget.item.item.description,
          ),
          SizedBox(height: 20),
          widget.item.variants.length > 0
              ? getVariantWidget(context)
              : getNoVariantWidget(),
          SizedBox(height: 16),
        ]),
      ),
    );
  }

  _buildVariants(context) {
    return Table(children: [
      for (int i = 0; i < options.length; ++i)
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(left: 55, right: 55, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffbc282b)),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              padding: EdgeInsets.only(left: 10, right: 10),
              // child: DropdownButtonHideUnderline(child: dropdowns[i]),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: _values[i],
                      elevation: 8,
                      hint: Text(options[i].name),
                      items: options[i]
                          .values
                          .map((e) => DropdownMenuItem(
                                child: Text(e.name),
                                value: e.name,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _values[i] = value;
                        });
                        getPrice();
                      })),
            ),
          )
        ])
    ]);
  }

  getVariantWidget(context) {
    return Column(children: [
      !match ? Text('Please Select Variant To See Price') : SizedBox(),
      SizedBox(
        height: 10,
      ),
      _buildVariants(context),
      match
          ? InkWell(
              splashColor: Colors.grey,
              child: ListTile(
                title: Text(
                  "$value " + widget.item.item.unit.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      "Rs ." +
                          (saleOrderItem.variant.salePrice * value).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(),
      Divider(height: 2),
      SizedBox(height: 10),
      match ? selection() : SizedBox(),
      nomatch ? Center(
        child: Text('Out of Stock!'),
      ) : SizedBox()
    ]);
  }

  Widget getNoVariantWidget() {
    return Column(children: [
      InkWell(
        splashColor: Colors.grey,
        child: ListTile(
          title: Text(
            value.toString() + ' ' + widget.item.item.unit.name,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          trailing: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                "Rs ." + (widget.item.item.salePrice * value).toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Divider(height: 2),
      SizedBox(height: 10),
      selection()
    ]);
  }

  Widget selection() {
    return Column(children: [
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 15,
          child: RaisedButton(
            color: Color(0xffcdaa44),
            onPressed: () {
              if (LocalData.currentCustomer != null) {
                for (var orderItem in CartList.getItems()) {
                  if (orderItem.itemId == widget.item.item.id) {
                    if (orderItem.variant != null) {
                      if (orderItem.variantId == saleOrderItem.variantId) {
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                                "${orderItem.product.name} already added to cart."),
                            action: SnackBarAction(
                              label: 'View',
                              onPressed: () async => {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Cart())),
                                setState(() {})
                              },
                            ),
                          ),
                        );
                      } else {
                        continue;
                      }
                    } else {
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(
                            "${orderItem.product.name} already added to cart.",
                          ),
                          action: SnackBarAction(
                            label: 'View',
                            onPressed: () async => {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cart())),
                              setState(() {})
                            },
                          ),
                        ),
                      );
                    }
                    return;
                  } else {
                    continue;
                  }
                }
                if (saleOrderItem != null) {
                  saleOrderItem.product = widget.item.item;
                  saleOrderItem.amount =
                      saleOrderItem.variant.salePrice * value;
                  saleOrderItem.itemId = widget.item.item.id;
                  saleOrderItem.price =
                      saleOrderItem.variant.salePrice.toString();
                  saleOrderItem.qty = value.toString();
                } else {
                  saleOrderItem = new SaleOrderItem();
                  saleOrderItem.product = widget.item.item;
                  saleOrderItem.amount =
                      saleOrderItem.product.salePrice * value;
                  saleOrderItem.itemId = widget.item.item.id;
                  saleOrderItem.price =
                      saleOrderItem.product.salePrice.toString();
                  saleOrderItem.qty = value.toString();
                }

                CartList.addToCart(saleOrderItem);
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content:
                        Text("${saleOrderItem.product.name} added to cart."),
                    action: SnackBarAction(
                      label: 'View',
                      onPressed: () async => {
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cart())),
                        setState(() {})
                      },
                    ),
                  ),
                );
              } else {
                _showErrorDialog("Warning!", "Please Sign In to View Cart!");
              }
            },
            child: Text("ADD TO MY BASKET",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    ]);
  }

  void _showErrorDialog(String title, String content) {
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
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: new Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signin()));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  getPrice() {
    var variant;
    switch (_values.length) {
      case 1:
        variant = _values[0];
        break;
      case 2:
        variant = _values[0] + '/' + _values[1];
        break;
      case 3:
        variant = _values[0] + '/' + _values[1] + '/' + _values[2];
        break;
    }
    for (var itemVariant in widget.item.variants) {
      if (variant == itemVariant.name) {
        nomatch = false;
        match = true;
        saleOrderItem = new SaleOrderItem();
        saleOrderItem.variant = itemVariant;
        saleOrderItem.variantId = itemVariant.id;
        print(saleOrderItem.toJson());
        break;
      } else {
        match = false;
        nomatch = true;
        saleOrderItem = null;
      }
      // else {
      //   match = false;
      //   nomatch = true;
      // }
      setState(() {});
    }
  }
}
