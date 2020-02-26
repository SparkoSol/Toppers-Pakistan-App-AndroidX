import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:topperspakistan/models/customer_model.dart';
import 'package:topperspakistan/models/local-data.dart';
import 'package:topperspakistan/pages/first.dart';
import 'package:topperspakistan/pages/forgot-password.dart';
import 'package:topperspakistan/pages/loading.dart';
import 'package:topperspakistan/services/customer_service.dart';

import '../firebase_auth.dart';

class Signin extends StatefulWidget {
  final _service = CustomerService();
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool autoValidate = false;
  bool loading = false;

  var _formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void login() async {
    CustomerModel customerModel = new CustomerModel();
    customerModel.email = emailController.text;
    customerModel.password = passwordController.text;
    CustomerModel signedCustomer = await widget._service.login(customerModel);

    if (signedCustomer == null) {
      setState(() {
        loading = false;
      });
      _showErrorDialog();
    } else {
      if (signedCustomer.email == null) {
        setState(() {
          loading = false;
        });
        _showErrorDialog();
      } else {
        LocalData.setProfile(signedCustomer);
        setState(() {
          loading = false;
        });
        print("Sign in id manual=> " + LocalData.getProfile().id.toString());
        print(LocalData.currentCustomer.name);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => First()));
      }
    }
  }

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
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          autovalidate: autoValidate,
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(15, 100, 15, 10),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Color(0xff666666),
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
                  style: TextStyle(color: Colors.white),
                  decoration: new InputDecoration(
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
                      Icons.person,
                      color: Colors.white,
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
                  color: Color(0xff666666),
                ),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter password" : null;
                  },
                  controller: passwordController,
                  style: TextStyle(color: Colors.white),
                  decoration: new InputDecoration(
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
                      Icons.lock,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: "Password",
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
                      login();
                    } else {
                      setState(() {
                        autoValidate = true;
                      });
                    }
                  },
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(28.0),
                      ),
                      color: Color(0xffBC282B),
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () async {
                        FirebaseAuthentication.googleAuth((user) async {
                          if (user == null) {
                            await GoogleSignIn().disconnect();
                            await GoogleSignIn().signOut();
                            print("Issue while signing in with google");
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "Error Occurred while signing-in"),
                                      actions: <Widget>[
                                        FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    ));
                          } else {
                            setState(() {
                              loading = true;
                            });
                            CustomerModel customerModel = new CustomerModel();
                            customerModel.name = user.displayName;
                            customerModel.email = user.email;
                            customerModel.password = "12345678";

                            var prof =
                                await widget._service.login(customerModel);
                            if (prof != null) {
                              print(prof.email);
                              if (prof.email == null) {
                                print("no sign in prof");
                                setState(() {
                                  loading = false;
                                });
                                await GoogleSignIn().disconnect();
                                await GoogleSignIn().signOut();
                                _showErrorDialog();
                              } else {
                                print("sign in");
                                LocalData.setProfile(prof);
                                setState(() {
                                  loading = false;
                                });
                                print("Google Sign in=> " + LocalData.getProfile().id.toString());
                                print(LocalData.currentCustomer.name);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => First()));
                              }
                            } else {
                              print("no sign in");
                              setState(() {
                                loading = false;
                              });
                              await GoogleSignIn().disconnect();
                              await GoogleSignIn().signOut();
                              _showErrorDialog();
                            }
                          }
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(28.0),
                      ),
                      color: Color(0xffBC282B),
                      child: Text(
                        "Sign in with Facebook",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () async {
                        FirebaseAuthentication.facebookAuth((user) async {
                          if (user == null) {
                            print("Issue while signing in with fb");
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "Error Occurred while signing-in"),
                                      actions: <Widget>[
                                        FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    ));
                          } else {
                            setState(() {
                              loading = true;
                            });
                            CustomerModel customerModel = new CustomerModel();
                            customerModel.name = user.displayName;
                            customerModel.email = user.email;
                            customerModel.password = "12345678";

                            var prof =
                                await widget._service.login(customerModel);
                            if (prof != null) {
                              print(prof.email);
                              if (prof.email == null) {
                                print("no sign in prof");
                                setState(() {
                                  loading = false;
                                });
                                _showErrorDialog();
                              } else {
                                print("sign in");
                                LocalData.setProfile(prof);
                                setState(() {
                                  loading = false;
                                });
                                print("Facebook Sign in=> " + LocalData.getProfile().id.toString());
                                print(LocalData.currentCustomer.name);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => First()));
                              }
                            } else {
                              print("no sign in");
                              setState(() {
                                loading = false;
                              });
                              _showErrorDialog();
                            }
                          }
                        });
                      }),
                ),
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
