import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:topperspakistan/cart/cart.dart';
import 'package:topperspakistan/cart_list.dart';
import 'package:topperspakistan/drawer/about_us.dart';
import 'package:topperspakistan/drawer/account.dart';
import 'package:topperspakistan/models/carosel_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/pages/carosalpage.dart';
import 'package:topperspakistan/pages/custom-drawer-guest.dart';
import 'package:topperspakistan/pages/custom-drawer.dart';
import 'package:topperspakistan/services/carosel_service.dart';
import 'package:topperspakistan/services/category_service.dart';
import 'package:topperspakistan/models/category_model.dart';
import 'package:shimmer/shimmer.dart';

import 'package:topperspakistan/drawer/notification.dart';
import 'package:topperspakistan/pages/model.dart';
import 'package:topperspakistan/pages/order.dart';

import '../simple-future-builder.dart';
import 'dart:async';
import 'dart:io';

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:google_fonts/google_fonts.dart';


class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  final _service = CategoryService();
  bool notification = false;

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    _fcm.subscribeToTopic("notifications");
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        final snackBar = SnackBar(content: Text(message['notification']['title']));
        print("On Message : $message");
              Future.delayed(Duration(seconds: 1)).then(
    (_) => _displaySnackbar(message['notification']['title'],message['notification']['body'] ));
           if(LocalData.currentCustomer != null ) {
            Scaffold.of(context).showSnackBar(snackBar);

          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Notification2()));
          setState(() {
            notification = true;
          });
        }
       
           
        //  Scaffold.of(context).showSnackBar(snackBar);
        //         print("On Print : $message");

        
            //     WidgetsBinding.instance
            // .addPostFrameCallback((_) => _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Your message here.."))));
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     content: ListTile(
        //       title: Row(
        //         children: <Widget>[
        //           Icon(Icons.notifications, color: Colors.blue),
        //           SizedBox(width: 15),
        //           Text(message['notification']['title']),
                  
        //         ],
        //       ),
        //       subtitle: 
        //           Text(message['notification']['body']),
               
        //     ),
        //     actions: <Widget>[
        //       FlatButton(
        //         child: Text("OK"),
        //         onPressed: ()=>Navigator.of(context).pop(),
        //       )
        //     ],
        //   )
        // );

      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch : $message");
           if(LocalData.currentCustomer != null ) {
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Notification2()));
        }
  
        
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume : $message");
        if(LocalData.currentCustomer != null ) {
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Notification2()));
        }
         
         
        //          showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     content: ListTile(
        //       title: Row(
        //         children: <Widget>[
        //           Icon(Icons.notifications, color: Colors.blue),
        //           SizedBox(width: 15),
        //           Text(message['notification']['title']),
                  
        //         ],
        //       ),
        //       subtitle: 
        //           Text(message['notification']['body']),
               
        //     ),
        //     actions: <Widget>[
        //       FlatButton(
        //         child: Text("OK"),
        //         onPressed: ()=>Navigator.of(context).pop(),
        //       )
        //     ],
        //   )
        // );
      }
    );
  }

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

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Do you want to exit this application?'),
            content: new Text('Hope to see you again!'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        key: _scaffoldKey,
        //  backgroundColor: Colors.black,
        appBar: AppBar(
          actions: <Widget>[
            new IconButton(
            icon: new Image.asset('images/ToppersPakistanLogo.png'),
            onPressed: null,
          ),
          SizedBox(
              width: 10.0,
            ),
          ],
          centerTitle: true,
          // backgroundColor: Colors.black,
          title: Text(
            "MENU",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                print(CartList.getItems().length);
                if (CartList.getItems().length == 0) {
                  _showErrorDialog("Warning", "Your Cart is Empty!");
                } else {
                  if (LocalData.currentCustomer == null) {
                    _showErrorDialog(
                        "Warning!", "Please Sign In to View Cart!");
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  }
                }
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.add_shopping_cart),
            ),
            Positioned(
              right: 7,
              top: 7,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  CartList.getItems() == null
                      ? "0"
                      : CartList.getItems().length.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        drawer: LocalData.currentCustomer == null
            ? CustomDrawerGuest()
            : CustomDrawer(),
        body: Container(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Carosal(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 18,
                  color: Color(0xffCE862A),
                  child: Center(
                      child: Text(
                    "CATEGORIES",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder<List<CategoryModel>>(
                    future: _service.fetchAll(),
                    builder:
                        (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
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
                                child: Text("No Categories Found"),
                              );
                            } else {
                              return GridView.builder(
                                  itemCount: snapshot.data.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1 / 1.05,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 5),
                                  itemBuilder: (context, i) {
                                    return Container(
                                        child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Order(
                                                categoryModel:
                                                    snapshot.data[i]),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                  "http://toppers-pakistan.toppers-mart.com/images/category/" +
                                                      snapshot.data[i].image,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder:
                                                      (context, widget, event) {
                                                if (event != null) {
                                                  return CircularProgressIndicator();
                                                } else if (widget != null) {
                                                  return widget;
                                                }
                                                return CircularProgressIndicator();
                                              }),
                                            ),
                                            height: 140,
                                            width: 140,
                                          ),
                                          SizedBox(height: 9),
                                          Text(snapshot.data[i].name)
                                        ],
                                      ),
                                    ));
                                  });
                            }
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ]),
        ),



      ),
    );

  }
  void  _displaySnackbar(title, message){
  _scaffoldKey.currentState.showSnackBar(SnackBar(
    duration: Duration(seconds: 2),
    content: Text(message)
  ));
  }
  
}
