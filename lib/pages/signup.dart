import 'package:flutter/material.dart';
import 'package:topperspakistan/models/customer_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/pages/branch_page.dart';
import 'package:topperspakistan/pages/loading.dart';
import 'package:topperspakistan/pages/privacy-policy.dart';
import 'package:topperspakistan/services/customer_service.dart';

import '../firebase_auth.dart';

class SignUp extends StatefulWidget {
  final _service = CustomerService();
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool autoValidate = false;
  bool loading = false;

  var _isUnique = false;
  final _service = CustomerService();
  var _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
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

  void register() async {
    print("register");
    CustomerModel customerModel = new CustomerModel();

    customerModel.name = nameController.text;
    customerModel.email = emailController.text;
    customerModel.phone = phoneController.text;
    customerModel.other = 0;

    if (passwordController.text == confirmPasswordController.text) {
      customerModel.password = passwordController.text;
    } else {
      setState(() {
        loading = false;
      });
      _showErrorDialog();
      return null;
    }

    CustomerModel signedCustomer = await widget._service.insert(customerModel);

    print(signedCustomer);
    if (signedCustomer == null) {
      print("no sign in");
      setState(() {
        loading = false;
      });
      _showErrorDialog();
    } else {
      if (signedCustomer.email == null) {
        print("no sign in");
        setState(() {
          loading = false;
        });
        _showErrorDialog();
      } else {
        print("sign in");

        LocalData.setProfile(signedCustomer);
        setState(() {
          loading = false;
        });

        print(LocalData.currentCustomer.name);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Branch()),
                (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Scaffold(
        backgroundColor: Color(0xffBE311A),
        body: Form(
          autovalidate: autoValidate,
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(15, 100, 15, 10),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                ),
                child: TextFormField(
                  validator: (value) {
                    return value.isEmpty ? "Please Enter name" : null;
                  },
                  controller: nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    // contentPadding: EdgeInsets.only(left: 20, top: 15),
                    errorStyle: TextStyle(color: Colors.black,),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    hintText: "Name",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                ),
                child: TextFormField(
                  validator: (value) {
                    if (!value.contains("@")) {
                      return "Please Enter Valid Email";
                    } else if (value.isEmpty) {
                      return "Please Enter Email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    errorStyle: TextStyle(color: Colors.black,),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter phone" : null;
                  },
                  controller: phoneController,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    errorStyle: TextStyle(color: Colors.black,),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    hintText: "Phone",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                ),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter Password" : null;
                  },
                  controller: passwordController,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    errorStyle: TextStyle(color: Colors.black,),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                ),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    return value.isEmpty ? "Please Retype Password" : null;
                  },
                  controller: confirmPasswordController,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    errorStyle: TextStyle(color: Colors.black,),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff66666),
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(28),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                  ),
                ),
              ),
              SizedBox(height: 20),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(28.0),
                  ),
                  color: Color(0xffCE862A),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      register();
                    } else {
                      setState(() {
                        autoValidate = true;
                      });
                    }
                  },
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "By signing up you agree to our  ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicy()));
                    },
                    child: Text(
                      'Terms & Conditions.',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.double,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
