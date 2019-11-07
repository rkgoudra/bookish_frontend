import 'dart:convert';

import 'package:bookish/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'CommonString.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  String name, Lname, email, mobile, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response =
        await http.post(CommonString.api_url+"api.php", body: {
      "flag": 2.toString(),
      "fname": name,
      "lname": Lname,
      "mail": email,
      "phno": mobile,
      "pwd": password,
    });

    //String jsonsDataString = response.body.toString();
    final data = jsonDecode(response.body);
    int value = data["status"];
    String message = data["message"];

    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      print(message);
      registerToast(message);
    } else {
      print(message);
      registerToast(message);
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xffFFCA50),
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: new AppBar(
      //title: new Text("Register"),
      backgroundColor: Colors.lightBlueAccent,

      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Image.asset("assets/bookShelf.jpg",height: 55.0 ),
              SafeArea(
                child: Center(
                  child: Image.asset(
                    'assets/book.png',
                  ),
                ),
              ),
              Card(
                elevation: 6.0,
                child: TextFormField(
                  validator: (e) {
                    String pattern = r'^[a-z A-Z,.\-]+$';
                    RegExp regExp = new RegExp(pattern);
                    if (e.length == 0) {
                      return 'Please enter first name';
                    } else if (!regExp.hasMatch(e)) {
                      return 'Please enter valid FirstName';
                    }
                    return null;
                  },
                  onSaved: (e) => name = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.all(18),
                      labelText: "FirstName"),
                ),
              ),
              Card(
                elevation: 6.0,
                child: TextFormField(

                  validator: (e) {
                    String pattern = r'^[a-z A-Z,.\-]+$';
                    RegExp regExp = new RegExp(pattern);
                    if (e.length == 0) {
                      return 'Please enter last name';
                    } else if (!regExp.hasMatch(e)) {
                      return 'Please enter valid LastName';
                    }
                    return null;
                  },
                  onSaved: (e) => Lname = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.all(18),
                      labelText: "LastName"),
                ),
              ),
              Card(
                elevation: 6.0,
                child: TextFormField(
                  validator: (e) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(e))
                      return 'Enter Valid Email';
                    else
                      return null;
                  },
                  onSaved: (e) => email = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Icon(Icons.email, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.all(18),
                      labelText: "Email"),
                ),
              ),
              Card(
                elevation: 6.0,
                child: TextFormField(

                  validator: (e){
                    Pattern pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    RegExp regex = new RegExp(pattern);
                    //print(e);
                    if (e.isEmpty) {
                      return 'Please enter password';
                    } else {
                      if (!regex.hasMatch(e))
                        return 'Min:8 char password(1 Alphabet,1 Numeric,1 Special)';
                      else
                        return null;
                    }                  },
                  obscureText: _secureText,
                  onSaved: (e) => password = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: Icon(_secureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Icon(Icons.phonelink_lock, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.all(18),
                      labelText: "Password"),
                ),
              ),
              Card(
                elevation: 6.0,
                child: TextFormField(
                  maxLength: 10,
                  validator: (e) {
                    String pattern =
                        r'^(?:(?:\+|0{0,2})91(\s*[\ -]\s*)?|[0]?)?[6789]\d{9}|(\d[ -]?){10}\d$';
                    RegExp regExp = new RegExp(pattern);
                    if (e.length == 0) {
                      return 'Please enter mobile number';
                    } else if (!regExp.hasMatch(e)) {
                      return 'enter valid India mobile number';
                    }
                    return null;
                  },
                  onSaved: (e) => mobile = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: Icon(Icons.phone, color: Colors.black),
                    ),
                    contentPadding: EdgeInsets.all(18),
                    labelText: "Mobile",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 55.0,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 22.0),
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          check();
                        }),
                  ),
                  SizedBox(
                    height: 55.0,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          "Login Page ",
                          style: TextStyle(fontSize: 22.0),
                        ),
                        textColor: Colors.black,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(
                            context
                          );
                          // registerToast("How are you");
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
