import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bookish/addbookjson.dart';
import 'package:bookish/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'CommonString.dart';


class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Add Books",
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: new EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  State createState() => new EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  File avatarImageFile, backgroundImageFile;
//******************************************************************************
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();
  var loading = false;
  List<dynamic> AllList = [];
  List<AddBookJson> list = [];
//******************************************************************************
  @override
  void initState() {
    super.initState();
    //getData();
    fetchData();
    _myActivities = [];
    _myActivitiesResult = '';
  }
//******************************************************************************
  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }
//******************************************************************************

   fetchData() async {
    setState(() {
      loading = true;
    });
    list.clear();
    final response =
//        await http.get("https://jsonplaceholder.typicode.com/posts");
    await http.post(CommonString.api_url + "api_get_gener.php", body: {
      "flag": 1.toString()
    });


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print(data);
      AllList = data;
      setState(() {
        for (Map i in data) {
          list.add(AddBookJson.fromJson(i));
          loading = false;
        }
      });
      print(AllList);
    }

  }

//******************************************************************************

  Future getImage(bool isAvatar) async {
    var result = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (isAvatar) {
        avatarImageFile = result;
      } else {
        backgroundImageFile = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    String bookTitile, authorName,language,description,isbn;

    return new SingleChildScrollView(
      child: Form(
        key: formKey,
        child:
      new Column(
        children: <Widget>[
          new Container(
            child: new Stack(
              children: <Widget>[

                // Avatar and button
                new Positioned(
                  child: new Stack(
                    children: <Widget>[
                      (avatarImageFile == null)
                          ?
                      InkWell(
                          onTap: () => getImage(true),
                           child: new Image.network(

                        'https://images-na.ssl-images-amazon.com/images/I/41gIrr4WtQL._SX296_BO1,204,203,200_.jpg',
                        width: SizeConfig.screenWidth*0.7,
                        height: SizeConfig.screenHeight*0.3,
                      )
                )
                          : new Material(
                        child: InkWell(
                            onTap: () => getImage(true),
                        child: new Image.file(
                          avatarImageFile,
                          width: SizeConfig.screenWidth*0.7,
                          height: SizeConfig.screenHeight*0.3,
                          fit: BoxFit.fitWidth,
                        )
                        ),

                        borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
                      ),
                    ],
                  ),
                  top: 15.0,
//                  left: MediaQuery.of(context).size.width / 2 - 70 / 2,
                  left: MediaQuery.of(context).size.width / 6.5,
                )
              ],
            ),
            width: double.infinity,
            height: 260.0,
          ),
          new Column(
            children: <Widget>[
              // Username
              new Container(
                child: new Text(
                  'Book Title',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, bottom: 5.0, top: 10.0),
              ),
              new Container(
                child: new TextFormField(
                  validator: (e) {
                    //String pattern = r'^[a-z A-Z,.\-]+$';
                    String pattern = r'^(?=.*[A-Za-z0-9])[A-Za-z0-9 _]*$';
                    RegExp regExp = new RegExp(pattern);
                    if (e.length == 0) {
                      return 'Please enter Book Title';
                    } else if (!regExp.hasMatch(e)) {
                      return 'Please enter valid Book Title';
                    }
                    return null;
                  },
                  onSaved: (e) => bookTitile = e,
                  decoration: new InputDecoration(
                      hintText: 'Farenheit 451',
                      border: new UnderlineInputBorder(),
                      contentPadding: new EdgeInsets.all(5.0),
                      hintStyle: new TextStyle(color: Colors.grey)),
                ),
                margin: new EdgeInsets.only(left: 30.0, right: 30.0),
              ),

              // Country
              new Container(
                child: new Text(
                  'Author Name',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                child: new TextFormField(
                  validator: (e) {
                    String pattern = r'^[a-z A-Z,.\-]+$';
                    RegExp regExp = new RegExp(pattern);
                    if (e.length == 0) {
                      return 'Please Author Name';
                    } else if (!regExp.hasMatch(e)) {
                      return 'Please enter valid Author Name';
                    }
                    return null;
                  },
                  onSaved: (e) => authorName = e,
                  decoration: new InputDecoration(
                      hintText: 'Ray Bradbury',
                      border: new UnderlineInputBorder(),
                      contentPadding: new EdgeInsets.all(5.0),
                      hintStyle: new TextStyle(color: Colors.grey)),
                ),
                margin: new EdgeInsets.only(left: 30.0, right: 30.0),
              ),

              // Address
              new Container(
                child: new Text(
                  'Language',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                child: new TextFormField(
                  validator: (e) {
                    String pattern = r'^[a-z A-Z,.\-]+$';
                    RegExp regExp = new RegExp(pattern);
                    if (e.length == 0) {
                      return 'Please enter Language';
                    } else if (!regExp.hasMatch(e)) {
                      return 'Please enter valid Language';
                    }
                    return null;
                  },
                  onSaved: (e) => language = e,
                  decoration: new InputDecoration(
                      hintText: 'English',
                      border: new UnderlineInputBorder(),
                      contentPadding: new EdgeInsets.all(5.0),
                      hintStyle: new TextStyle(color: Colors.grey)),
                ),
                margin: new EdgeInsets.only(left: 30.0, right: 30.0),
              ),

              // About me
              new Container(

                child: new Text(
                  'Description',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                child: new TextFormField(
                  validator: (e) {
                    String pattern = r'^[a-z A-Z,.\-]+$';
                    RegExp regExp = new RegExp(pattern);
                    if (e.length == 0) {
                      return 'Please enter Description';
                    } else if (!regExp.hasMatch(e)) {
                      return 'Please enter valid Description';
                    }
                    return null;
                  },
                  onSaved: (e) => description = e,
                  decoration: new InputDecoration(
                      hintText: 'entire novel about the future and the burning of books',
                      border: new UnderlineInputBorder(),
                      contentPadding: new EdgeInsets.all(5.0),
                      hintStyle: new TextStyle(color: Colors.grey)),
                ),
                margin: new EdgeInsets.only(left: 30.0, right: 30.0),
              ),

              // About me
              new Container(
                child: new Text(
                  'ISBN',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                child: new TextFormField(
                  validator: (e) {
                    String pattern = r'^\d{9}[\d|X]$';
                    RegExp regExp = new RegExp(pattern);
                    if (e.length == 0) {
                      return 'Please enter ISBN';
                    } else if (!regExp.hasMatch(e)) {
                      return 'Please enter valid ISBN';
                    }
                    return null;
                  },
                  onSaved: (e) => isbn = e,
                  decoration: new InputDecoration(
                      hintText: '9788429772456',
                      border: new UnderlineInputBorder(),
                      contentPadding: new EdgeInsets.all(5.0),
                      hintStyle: new TextStyle(color: Colors.grey)),
                  keyboardType: TextInputType.number,
                ),
                margin: new EdgeInsets.only(left: 30.0, right: 30.0),
              ),
              new Container(
                child: new Text(
                  'Gener',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),

              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: false,
                  titleText: 'Category',
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                  },
                  dataSource: AllList,

               textField: 'gener_name',
                  valueField: 'gener_id',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  // required: true,
                  hintText: 'Please choose one or more',
                  value: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
               Container(

                padding: const EdgeInsets.only(top: 12, left: 40, bottom: 10),
                child: RaisedButton(
                  splashColor: Colors.pinkAccent,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      //splashColor: Colors.pinkAccent,

                      borderRadius: BorderRadius.circular(12.0)),
                      elevation: 5,
//                  child: Text('Save'),
                  onPressed: _saveForm,
                  child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 20)
                  ),
                ),

              ),


              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              )

            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
      ),
      ),
      padding: new EdgeInsets.only(bottom: 20.0),
    );
  }
}