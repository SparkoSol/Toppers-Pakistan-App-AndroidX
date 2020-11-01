import 'package:flutter/material.dart';
import 'package:topperspakistan/models/address_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/services/addresses_service.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool autoValidate = false;
  final _service = new AddressService();
  var _formKey = GlobalKey<FormState>();

  void addAddress() async {
    AddressModel addressModel = new AddressModel();
    addressModel.description = descriptionController.text;
    addressModel.house = houseController.text;
    addressModel.street = streetController.text;
    addressModel.city = cityController.text;
    addressModel.area = areaController.text;
    addressModel.mobile = mobileController.text;
    addressModel.customerId = LocalData.currentCustomer.id.toString();

    _service.insert(addressModel);

    Navigator.pop(context);
  }

  TextEditingController descriptionController = new TextEditingController();
  TextEditingController houseController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController areaController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADD ADDRESS",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Image.asset('images/LogoTrans.png'),
            onPressed: null,
            iconSize: 80.0,
          ),
        ],
      ),
      body: Form(
        autovalidate: autoValidate,
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                return value.isEmpty ? "Please Enter Description" : null;
              },
              controller: descriptionController,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(15), hintText: "Description"),
            ),
            SizedBox(
              height: 10,
            ),
            new TextFormField(
              validator: (value) {
                return value.isEmpty ? "Please Enter House" : null;
              },
              controller: houseController,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(15), hintText: "House"),
            ),
            SizedBox(
              height: 10,
            ),
            new TextFormField(
              validator: (value) {
                return value.isEmpty ? "Please Enter Street" : null;
              },
              controller: streetController,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(15), hintText: "Street"),
            ),
            TextFormField(
              validator: (value) {
                return value.isEmpty ? "Please Enter Area" : null;
              },
              controller: areaController,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(15), hintText: "Area"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                return value.isEmpty ? "Please Enter City" : null;
              },
              controller: cityController,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(15), hintText: "City"),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                return value.isEmpty ? "Please Enter Mobile No." : null;
              },
              controller: mobileController,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Mobile Number"),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                child: RaisedButton(
                  color: Color(0xffCE862A),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (_formKey.currentState.validate()) {
                      addAddress();
                    } else {
                      setState(() {
                        autoValidate = true;
                      });
                    }
                  },
                  child: Text("Add Address",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
