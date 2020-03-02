import 'package:flutter/material.dart';
import 'package:topperspakistan/cart/place-order.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int selectedRadio=1;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
    print(selectedRadio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        actions: <Widget>[
            new IconButton(
            icon: new Image.asset('images/ToppersPakistanLogo.png'),
            onPressed: null,
          ),
          SizedBox(
              width: 10.0,
            ),
          ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 15,
            child: RaisedButton(
              color: Color(0xffcdaa44),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PlaceOrder()));
              },
              child: Text("Proceed",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: Radio(
                  activeColor: Colors.black,
                  value: 1,
                  groupValue: selectedRadio,
                  onChanged: (val) {
                    setSelectedRadio(val);
                  },
                ),
                title: Text("Cash on Delivery"),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: Radio(
                  activeColor: Colors.black,
                  value: 2,
                  groupValue: selectedRadio,
                  onChanged: (val) {},
                ),
                subtitle: Text("Comming Soon!"),
                title: Text("Easy Paisa"),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: Radio(
                  activeColor: Colors.black,
                  value: 3,
                  groupValue: selectedRadio,
                  onChanged: (val) {
                  },
                ),
                subtitle: Text("Comming Soon!"),
                title: Text("MobiCash"),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          )
        ],
      ),
    );
  }
}
