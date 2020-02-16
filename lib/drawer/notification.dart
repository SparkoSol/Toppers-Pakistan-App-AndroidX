import 'package:flutter/material.dart';

class Notification2 extends StatefulWidget {
  @override
  _Notification2State createState() => _Notification2State();
}

class _Notification2State extends State<Notification2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar( title: Text("NOTIFICATION"),centerTitle: true,),
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[


        Icon(Icons.notifications,size: 130,),SizedBox(height: 10,)
,
Text("No Notification Found")      ],
    ),),);
  }
}