import 'package:flutter/material.dart';

class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ABOUT US",
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
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.black45,
                        size: 20,
                      ),
                      Text(
                        " About Toppers Pakistan",
                        style: TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Here at Toppers Pakistan we use fresh , locally sourced produce to create healthy, convenient meals delivered direct to you",
                    style: TextStyle(color: Colors.black45),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.train,
                    color: Colors.black45,
                    size: 20,
                  ),
                  Text(
                    "Delivery Charges ",
                    style: TextStyle(color: Colors.black45),
                  ),
                  Text(
                    "(PKR 50.00)",
                    style: TextStyle(color: Colors.black45),
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.timer,
                        color: Colors.black45,
                        size: 20,
                      ),
                      Text(
                        "Delivery Time",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Order will be delivered within 30 to 45 mins.",
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
