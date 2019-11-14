import 'dart:convert';

import 'package:bookish/register.dart';
import 'package:bookish/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'CommonString.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String name, Lname, email, mobile, password;
  TextStyle style = TextStyle(fontSize: 20.0, color: Colors.white);

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
    final response = await http.post(CommonString.api_url + "api.php", body: {
      "flag": 1.toString(),
      "mail": email,
      "pwd": password,
    });

    //String jsonsDataString = response.body.toString();
    final data = jsonDecode(response.body);
    int value = data["status"];
    String message = data["message"];
    String usrId = data["user_id"];
    String usrName = data["user_name"];
    String mailId = data["email"];

    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, mailId, usrName, usrId);
      });
      print(message);
      loginToast(message);
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xffFFCA50),
        textColor: Colors.white);
  }

  savePref(int value, String email, String name, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);

      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        final emailField = Card(
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
                contentPadding: EdgeInsets.all(12),
                labelText: "Email"),
          ),
        );
        final passwordField = Card(
          elevation: 6.0,
          child: TextFormField(
            validator: (e) {
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
              }
            },
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
                  icon: Icon(
                      _secureText ? Icons.visibility_off : Icons.visibility),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20, right: 15),
                  child: Icon(Icons.phonelink_lock, color: Colors.black),
                ),
                contentPadding: EdgeInsets.all(12),
                labelText: "Password"),
          ),
        );
        final loginButon = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(CommonString.btn_color),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              check();
            },
            child: Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
        final SignUpButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(CommonString.btn_color),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text("SignUp",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _key,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: AssetImage("assets/bookShelf.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.deepPurpleAccent.withOpacity(0.3),
                        BlendMode.dstATop),
                  ),
                ),
                child: Padding(

                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    //height: SizeConfig.safeBlockVertical * 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                       height: SizeConfig.safeBlockVertical * 20,
                        child: Image.asset(
                          "assets/book.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 45.0),
                      emailField,
                      SizedBox(height: 15.0),
                      passwordField,
                      SizedBox(
                        height: 25.0,
                      ),
                      loginButon,
                      SizedBox(
                        height: 20.0,
                      ),
                      SignUpButton,
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        break;

      case LoginStatus.signIn:
        return MainMenu(signOut);
//        return ProfilePage(signOut);
        break;
    }
  }
}
