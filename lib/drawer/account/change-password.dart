import 'package:flutter/material.dart';
import 'package:topperspakistan/models/customer_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/services/customer_service.dart';

class ChangePassword extends StatefulWidget {
  final _service = CustomerService();

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool autoValidate = false;

  var _formKey = GlobalKey<FormState>();

  TextEditingController oldpasswordController = new TextEditingController();
  TextEditingController newpasswordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();
  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: new Text(
              "Error",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: Text(
              "Please Provide Valid Credentials",
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

  void changePassword() async {
    print("change password");

    if (newpasswordController.text == confirmpasswordController.text) {
      var customerModel = {
        "password": newpasswordController.text,
        "oldpassword": oldpasswordController.text
      };

      CustomerModel signedCustomer = await widget._service
          .changePassword(customerModel, LocalData.currentCustomer.id);

      if (signedCustomer == null) {
        print("no sign in");
        _showErrorDialog();
      } else {
        if (signedCustomer.email == null) {
          print("no sign in");
          _showErrorDialog();
        } else {
          print("sign in");

          LocalData.currentCustomer = signedCustomer;

          Navigator.pop(context);
        }
      }
    } else {
      _showErrorDialog();
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
            new IconButton(
            icon: new Image.asset('images/ToppersPakistanLogo.png'),
            onPressed: null,
          ),
          SizedBox(
              width: 10.0,
            ),
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Form(
          autovalidate: autoValidate,
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter Old Password" : null;
                  },
                  controller: oldpasswordController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(3.0),
                      ),
                    ),
                    hintText: "Old Password",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter New Password" : null;
                  },
                  controller: newpasswordController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(3.0),
                      ),
                    ),
                    hintText: "New Password",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    return value.isEmpty ? "Please Retype New Password" : null;
                  },
                  controller: confirmpasswordController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(3.0),
                      ),
                    ),
                    hintText: "Confirm New Password",
                  ),
                ),
              ),
              SizedBox(height: 20),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                child: RaisedButton(
                  color: Color(0xffCE862A),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (_formKey.currentState.validate()) {
                      changePassword();
                    } else {
                      setState(() {
                        autoValidate = true;
                      });
                    }
                  },
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //  Padding(
      //   padding: const EdgeInsets.all(13.0),
      //   child: Column(
      //     children: <Widget>[
      //       TextField(
      //         controller: newpasswordEditingController,
      //         decoration: new InputDecoration(
      //             errorText: _validate ? "password is required" : null,
      //             border: new OutlineInputBorder(
      //               borderRadius: const BorderRadius.all(
      //                 const Radius.circular(3.0),
      //               ),
      //             ),
      //             hintText: "password"),
      //         onChanged: (value) {
      //           setState(() {
      //             newpasswordEditingController.text.isEmpty
      //                 ? _validate = true
      //                 : _validate = false;
      //           });
      //         },
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       new TextField(
      //         obscureText: true,
      //         controller: confirmEditingController,
      //         decoration: new InputDecoration(
      //             errorText: _validate2 ? "Password is required" : null,
      //             border: new OutlineInputBorder(
      //               borderRadius: const BorderRadius.all(
      //                 const Radius.circular(3.0),
      //               ),
      //             ),
      //             hintText: "Confirm Password"),
      //         onChanged: (value) {
      //           setState(() {
      //             confirmEditingController.text.isEmpty
      //                 ? _validate2 = true
      //                 : _validate2 = false;
      //           });
      //         },
      //       ),
      //       SizedBox(
      //         height: 15,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 15),
      //         child: ButtonTheme(
      //           minWidth: MediaQuery.of(context).size.width,
      //           height: MediaQuery.of(context).size.height / 15,
      //           child: RaisedButton(
      //             color: Color(0xffCE862A),
      //             onPressed: () {
      //               if (newpasswordEditingController.text.isEmpty &&
      //                   confirmEditingController.text.isEmpty) {
      //                 setState(() {
      //                   newpasswordEditingController.text.isEmpty
      //                       ? _validate = true
      //                       : _validate = false;
      //                 });
      //                 setState(() {
      //                   confirmEditingController.text.isEmpty
      //                       ? _validate2 = true
      //                       : _validate2 = false;
      //                 });
      //               } else {
      //                 Navigator.pop(context);
      //               }
      //             },
      //             child: Text("Change Password",
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 18,
      //                     fontWeight: FontWeight.w400)),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // )
    );
  }
}
