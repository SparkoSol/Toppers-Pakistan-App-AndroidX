import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:topperspakistan/cart/cart.dart';
import 'package:topperspakistan/drawer/about_us.dart';
import 'package:topperspakistan/drawer/account.dart';
import 'package:topperspakistan/drawer/notification.dart';
import 'package:topperspakistan/firebase_auth.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:topperspakistan/pages/homepage.dart';

import '../cart_list.dart';

class CustomDrawer extends StatelessWidget {
  void _showErrorDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: new Text(
              "Warning!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: Text(
              "Your Cart is Empty!",
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
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: Center(
              child: Image.asset('images/ToppersPakistanLogo.png'),
            ),
            height: MediaQuery.of(context).size.height / 5,
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            color: Color(0xffbc282b),
            height: MediaQuery.of(context).size.height / 15,
            child: Center(
              child: Text(
                "Welcome " + LocalData.getProfile().name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.fastfood,
              color: Colors.black,
            ),
            title: Text(
              "MENU",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () {
              if (CartList.getItems().length == 0) {
                _showErrorDialog(context);
              } else {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              }
            },
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            title: Text(
              "MY BASKET",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUS()));
            },
            leading: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            title: Text(
              "ABOUT US",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Account()));
            },
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text(
              "MY ACCOUNT",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notification2()));
            },
            leading: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            title: Text(
              "NOTIFICATIONS",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () async {
              if (await GoogleSignIn().isSignedIn()) {
                print("google sign out");
                await GoogleSignIn().disconnect();
                await GoogleSignIn().signOut();
              }
              if (await FacebookLogin().isLoggedIn) {
                print(true);
                await FacebookLogin().logOut();
                await FirebaseAuth.instance.signOut();
              }
              print("object");
              LocalData.currentCustomer = null;
              CartList.emptyCartList();
              CartList.instruction = "";
              CartList.address = null;
              CartList.totalPrice = 0;
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            leading: Icon(
              Icons.devices_other,
              color: Colors.black,
            ),
            title: Text(
              "SIGN OUT",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
        ],
      ),
    );
  }
}
