import 'package:flutter/material.dart';
import 'package:topperspakistan/pages/homepage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffBE311A),
      body: Center(
          child: Image.asset(
        "images/ApnaStore.png",
        height: 250,
        width: 250,
      )),
    );
  }
}
