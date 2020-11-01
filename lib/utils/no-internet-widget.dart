import 'package:flutter/material.dart';

class ShowNoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.signal_cellular_connected_no_internet_4_bar,color: Colors.white,size: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("No Internet Connection!"),
          ),
        ],
      ),
    );
  }
}
