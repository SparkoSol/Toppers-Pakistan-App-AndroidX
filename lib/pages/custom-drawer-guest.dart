import 'dart:io';

import 'package:flutter/material.dart';
import 'package:topperspakistan/drawer/about_us.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/pages/signin.dart';
import 'package:topperspakistan/pages/signup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'privacy-policy.dart';


class CustomDrawerGuest extends StatelessWidget {
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
              child: Image.asset('images/LogoTrans.png'),
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
              "Welcome Guest",
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
              Icons.info,
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
              LocalData.currentCustomer = null;
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Signin()));
            },
            leading: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            title: Text(
              "SIGN IN",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 0,
          ),
          ListTile(
            onTap: () {
              LocalData.currentCustomer = null;
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            leading: Icon(
              Icons.person_add,
              color: Colors.black,
            ),
            title: Text(
              "SIGN UP",
              style: TextStyle(color: Colors.black),
            ),
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
