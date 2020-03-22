import 'package:flutter/material.dart';
import 'package:topperspakistan/cart/cart.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/pages/first.dart';
import 'package:topperspakistan/pages/signin.dart';
import 'package:topperspakistan/pages/signup.dart';
import 'package:topperspakistan/utils/connectivityService.dart';
import 'package:topperspakistan/utils/no-internet-widget.dart';

import '../cart_list.dart';
import 'custom-drawer-guest.dart';
import 'custom-drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInternetConnected = false;
  void _showErrorDialog(String title, String content) {
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
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    isInternetConnected = checkConnectionStatus(context);

    return LocalData.getProfile() != null
        ? isInternetConnected
            ? First()
            : Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    new IconButton(
                      icon: new Image.asset(
                        'images/LogoTrans.png',
                      ),
                      iconSize: 80,
                      onPressed: null,
                    ),
                  ],
                  centerTitle: true,
                  // backgroundColor: Colors.black,
                  title: Text(
                    "MENU",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                drawer: LocalData.currentCustomer == null
                    ? CustomDrawerGuest()
                    : CustomDrawer(),
                body: Center(child: ShowNoInternet()))
        : isInternetConnected
            ? Scaffold(
                backgroundColor: Color(0xffBE311A),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          child: Image.asset(
                            "images/Logo.png",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 1.3,
                        height: MediaQuery.of(context).size.height / 15,
                        child: RaisedButton(
                          color: Color(0xffCE862A),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(28.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signin()));
                          },
                          child: Text("SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 1.3,
                        height: MediaQuery.of(context).size.height / 15,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(28.0),
                          ),
                          color: Color(0xffCE862A),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text("SIGN UP",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 1.3,
                        height: MediaQuery.of(context).size.height / 15,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(28.0),
                          ),
                          color: Color(0xff000000),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => First()));
                          },
                          child: Text(
                            "Proceed As A Guest",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Scaffold(body: Center(child: ShowNoInternet()));
  }
}
