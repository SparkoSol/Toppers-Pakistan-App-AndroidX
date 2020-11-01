import 'package:flutter/material.dart';
import 'package:topperspakistan/cart/paymentmethod.dart';
import 'package:topperspakistan/cart_list.dart';
import 'package:topperspakistan/drawer/account/add-address.dart';
import 'package:topperspakistan/models/address_model.dart';
import 'package:topperspakistan/services/addresses_service.dart';
import 'package:topperspakistan/simple-future-builder.dart';

class SelectDeliveryAddress extends StatefulWidget {
  @override
  _SelectDeliveryAddressState createState() => _SelectDeliveryAddressState();
}

class _SelectDeliveryAddressState extends State<SelectDeliveryAddress> {
  int selectedRadio;
  final _service = AddressService();
  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: new Text(
              "Error",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: Text(
              "Please Select a Delivery Address!",
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
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
    print(selectedRadio);
    print(CartList.address.mobile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Address",
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 15,
            child: RaisedButton(
              color: Color(0xffCE862A),
              onPressed: () {
                if (CartList.address == null) {
                  _showErrorDialog();
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaymentMethod()));
                }
              },
              child: Text("Select Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,color:Colors.white)),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffbc282b),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddAddress()));
        },
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 8,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.check,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Center(
                    child: Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 18),
                  // textAlign: ,
                ))
              ],
            ),
          ),
          Expanded(
            child: SimpleFutureBuilder<List<AddressModel>>.simpler(
              future: _service.fetchAllByCustomerId(),
              context: context,
              builder: (AsyncSnapshot<List<AddressModel>> snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: <Widget>[
                        Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          leading: Radio(
                            activeColor: Colors.black,
                            value: snapshot.data[i].id,
                            groupValue: selectedRadio,
                            onChanged: (val) {
                              CartList.address = snapshot.data[i];
                              setSelectedRadio(val);
                            },
                          ),
                          title: Text(snapshot.data[i].description),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.data[i].house +
                                  ", " +
                                  snapshot.data[i].street +
                                  ", " +
                                  snapshot.data[i].area),
                              Text("Phone:" + snapshot.data[i].mobile),
                            ],
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _service.delete(snapshot.data[i]);
                                setState(() {});
                              }),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
