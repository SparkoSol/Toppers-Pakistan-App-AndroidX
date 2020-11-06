import 'package:flutter/material.dart';
import 'package:topperspakistan/pages/result.dart';
import 'package:topperspakistan/services/customer_service.dart';

import 'loading.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _validate = false;

  TextEditingController emailEditingController = new TextEditingController();
  void _showLoadingDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20,),
                    Text('Loading')
                  ],
            ),
          );
        });
  }

  void forgetPass() async {
    _showLoadingDialog();
    var customerService = CustomerService();
    bool result =
        await customerService.forgetPassword(emailEditingController.text);
    print(result);
    Navigator.pop(context);
    if (result) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Result(status: true)));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Result(status: false)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffBE311A),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 220, 15, 0),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28), color: Colors.white),
            child: TextField(
              controller: emailEditingController,
              style: TextStyle(color: Colors.black),
              decoration: new InputDecoration(
                  hoverColor: Colors.white,
                  errorText: _validate ? "Email is required" : null,
                  focusedBorder: new OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff66666)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(28),
                    ),
                  ),
                  errorStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: new OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff66666)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(28),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  hintText: "Email"),
              onChanged: (value) {
                setState(() {
                  emailEditingController.text.isEmpty
                      ? _validate = true
                      : _validate = false;
                });
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 15,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(28.0),
              ),
              color: Color(0xffCE862A),
              onPressed: () {
                if (emailEditingController.text.isEmpty) {
                  setState(() {
                    emailEditingController.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                  });
                } else {
                  forgetPass();
                }
              },
              child: Text("Proceed",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}
