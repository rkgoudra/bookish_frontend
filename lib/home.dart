import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookish"),
      ),
      body:Column(
        children: <Widget>[

        Container(
      height: 200.0,
        width: 200.0,
        child:Card(
          child: Column(
            children: <Widget>[

              Text("card VIew"),
            ],
          ),
        ),
      ),
          Container(
            height: 200.0,
            width: 200.0,
            child:Card(
              child: Column(
                children: <Widget>[

                  Text("card VIew"),
                ],
              ),
            ),
          ),
        ],
      )

     ,
      drawer: Drawer(

      child: ListView(

        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Image.asset("assets/book.png",
            height: 100.0,
            width: 100.0,
          ),
          Center(child: Text("Bookish",style: TextStyle(fontSize: 20.0),),
          ),

          ListTile(
            leading: Image.asset("assets/total.png"),
            title: Text("Books"),
          ),
          SizedBox(
            height: 10.0 ,
          ),
          ListTile(
            leading: Image.asset("assets/lent.png"),
            title: Text("Lent Books"),
          ),
          SizedBox(
            height: 10.0 ,
          ),
          ListTile(
            leading: Image.asset("assets/borrowed.png"),
            title: Text("Borrowed Books"),

          ),
        ],
      ),
    ),
    );
  }
}