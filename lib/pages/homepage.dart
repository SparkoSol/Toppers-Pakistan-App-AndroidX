import 'package:flutter/material.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/pages/first.dart';
import 'package:topperspakistan/pages/signin.dart';
import 'package:topperspakistan/pages/signup.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("Profile=>" + LocalData.getProfile().toString());
    return LocalData.getProfile() == null
        ? Scaffold(
            backgroundColor: Colors.black,
            // body: Center(
            //   child: RaisedButton(
            //     onPressed: () {},
            //     textColor: Colors.white,
            //     padding: const EdgeInsets.all(0.0),
            //     child: Container(
            //       decoration: const BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: <Color>[
            //             Color(0xffCE862A),
            //             Color(0xff000000),
            //             Color(0xffCE862A),
            //             Color(0xff000000),
            //             Color(0xffCE862A),
            //           ],
            //         ),
            //       ),
            //       padding: const EdgeInsets.all(10.0),
            //       child: const Text('Gradient Button',
            //           style: TextStyle(fontSize: 20)),
            //     ),
            //   ),
            // ),
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
                        "images/ToppersPakistanLogo.png",
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signin()));
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
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
                      color: Color(0xffBC282B),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => First()));
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
        : First();
  }
}
