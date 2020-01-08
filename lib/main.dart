import 'package:bookish/CommonString.dart';
import 'package:bookish/login.dart';
import 'package:flutter/material.dart';

import 'BarcodeQr.dart';

void main() => runApp(MyApp());
//void main() => runApp(BarcodeQr());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookish',
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CommonString.yellow,
      ),
      home: LoginPage(title: 'Android application to maintain books'),
    );
  }
}
