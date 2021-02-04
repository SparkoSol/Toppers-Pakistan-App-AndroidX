import 'package:flutter/material.dart';
import 'package:topperspakistan/pages/signin.dart';

class Result extends StatelessWidget {
  final status;

  Result({this.status});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "images/ApnaStore.png",
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                child: status
                    ? Text(
                        "An Email sent for Password Reset",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    : Text("There was an Error recovering your email.",
                        style: TextStyle(fontSize: 18, color: Colors.white))),
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
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Signin()));
                },
                child: Text("SIGN IN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
