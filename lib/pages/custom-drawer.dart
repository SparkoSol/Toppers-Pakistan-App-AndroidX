import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:topperspakistan/cart/cart.dart';
import 'package:topperspakistan/drawer/about_us.dart';
import 'package:topperspakistan/drawer/account.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:topperspakistan/pages/homepage.dart';
import 'package:topperspakistan/pages/notification-page.dart';
import 'package:topperspakistan/rate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'branch_page.dart';
import 'privacy-policy.dart';

import '../cart_list.dart';

class CustomDrawer extends StatelessWidget {
  void _showErrorDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
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
          Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Image.asset('images/ApnaStore.png', height: 65),
                  GestureDetector(
                      onTap: () => {
                            Navigator.pop(context),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Branch())),
                          },
                      child: Column(
                        children: [
                          Text(LocalData.branchId != null
                              ? LocalData.branchId.name.toString()
                              : '', textAlign: TextAlign.center,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Swap Branch'),
                              Icon(
                                Icons.arrow_forward,
                                size: 18,
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
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
              "Menu",
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
              "My Basket",
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
                    context, MaterialPageRoute(builder: (context) => Branch()));
            },
            leading: Icon(
              Icons.store,
              color: Colors.black,
            ),
            title: Text(
              "Swap Branch",
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
              "About Us",
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
              launchWhatsApp(phone: '+92 300 1300533', message: '');
            },
            leading: Icon(
              Icons.phone,
              color: Colors.black,
            ),
            title: Text(
              "Contact Us",
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
              "My Account",
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
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            leading: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            title: Text(
              "Notifications",
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
              Rate.getRate()
                  .showRateDialog(context,
                      title: "Rate Apna Store",
                      message:
                          "If you like Apna Store, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.")
                  .then((_) => {});
            },
            leading: Icon(
              Icons.rate_review,
              color: Colors.black,
            ),
            title: Text(
              "Rate Us",
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
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()));
            },
            leading: Icon(
              Icons.assignment,
              color: Colors.black,
            ),
            title: Text(
              "Privacy Policy",
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
              LocalData.logout();
              // CartList.emptyCartList();
              CartList.instruction = "";
              CartList.address = null;
              CartList.totalPrice = 0;
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.black,
            ),
            title: Text(
              "Sign Out",
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


void launchWhatsApp(
    {@required String phone,
      @required String message,
    }) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
    } else {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}