import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';


import 'package:avatar_glow/avatar_glow.dart';
import 'package:bookish/CommonString.dart';
import 'package:bookish/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'ProfileJson.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String email = "", name = "", id = "";

  //Dropdown Items with id and name
  String _mySelection, gendersaved;
  List<Map> _myJson = [
    {"id": 1, "name": "Male"},
    {"id": 0, "name": "Female"}
  ];

  File image;
  var random = Random();
  final GlobalKey<ScaffoldState> _scaf = new GlobalKey<ScaffoldState>();

  TextEditingController controller = new TextEditingController();

  var loading=false;
List<ProfileJson> list= [];
List<dynamic> AllList= [];

  List<ProfileJson> _search = [];

  var refreshKey = GlobalKey<RefreshIndicatorState>();

//  save() async {
//    final response = await http.post(CommonString.api_url + "api_profile.php", body: {
//      "flag": 1.toString(),
//      "id": id,
//    });
//
//  }
  fetchData() async {
    //print(CommonString.api_url + "api_profile.php");
    setState(() {
      loading = true;
    });
    list.clear();
    final response =
    await http.post(CommonString.api_url + "api_profile.php", body: {
      "flag": "1",
      "id": id,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      AllList = data;
      setState(() {
        for (Map i in data) {
          list.add(ProfileJson.fromJson(i));
          loading = false;
        }
        print("----------Start--------------");
        print(AllList);
//        print(AllList[4]);
      });

    }

  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
    });
    print("id" + id);
    print("user" + email);
    print("name" + name);
//    //save();
    fetchData();
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
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              loading
                  ? Center(
                child: new Column(
                  children: <Widget>[
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 200,
                            height: 450,
                          ),
//                          child: CircularProgressIndicator(),
                          padding: EdgeInsets.only(bottom: 140.0),
                        ),
                      ],
                    ),
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: fetchData,
                      child: new Text("Click here to Refresh Page"),
                    ),
                  ],
                ),
              )
                  : Expanded(
                child: _search.length != 0 || controller.text.isNotEmpty
                    ? null
                    : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final a = list[i];
                    gendersaved = a.gender;

                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
//                                      color: Colors.black,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 6.0,
                            ),
                            InkWell(
                              onTap: () async {
                                String imgname = "defalut.jpg";
                                var img =
                                await ImagePicker.pickImage(
                                    source:
                                    ImageSource.gallery);

                                final tempDir =
                                await getTemporaryDirectory();

                                final path = tempDir.path;
                                setState(() {
                                  var gen =
                                  random.nextInt(1000000000);
                                  imgname = gen.toString();
                                });
                                Img.Image imgs = Img.decodeImage(
                                    img.readAsBytesSync());
                                Img.Image smallerimg =
                                Img.copyResize(imgs);

                                var compressimg =
                                new File("$path/$imgname.jpg")
                                  ..writeAsBytesSync(
                                      Img.encodeJpg(
                                          smallerimg,
                                          quality: 85));
                                print(compressimg.toString());
                                setState(() {
                                  image = compressimg;
                                });

                                uploadimg();
                              },
                              child: AvatarGlow(
                                glowColor: Colors.red,
                                endRadius: 90.0,
                                duration:
                                Duration(milliseconds: 2000),
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                Duration(milliseconds: 100),
                                child: Material(
                                  elevation: 6.0,
                                  shape: CircleBorder(),
                                  child: CircleAvatar(
                                    maxRadius: 80.0,
                                    backgroundColor:
                                    Colors.blue.shade50,
                                    backgroundImage:
                                    new NetworkImage(a.photo),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: new InkWell(
//                                onTap: openDialogName,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      100.0,
                                  height: 45.0,
                                  padding: EdgeInsets.all(10.0),
                                  child: new Text(
                                    a.fname,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: new InkWell(
//                                onTap: openDialogGender,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      100.0,
                                  height: 45.0,
                                  padding: EdgeInsets.all(10.0),
                                  child: new Text(
                                    a.lname,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: new InkWell(
//                                onTap: openDialogDOB,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      100.0,
                                  height: 45.0,
                                  padding: EdgeInsets.all(10.0),
                                  child: new Text(
                                    a.email,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: new InkWell(
//                                onTap: openDialogMobile,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      100.0,
                                  height: 45.0,
                                  padding: EdgeInsets.all(10.0),
                                  child: new Text(
                                    a.phone,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              child: new InkWell(
                                onTap: openDialogGender,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      100.0,
                                  height: 45.0,
                                  padding: EdgeInsets.all(10.0),
                                  child: new Text(
                                    a.gender,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Card(
                                  color: Colors.black,
                                  child: new RaisedButton(
                                    child:
                                    new Text("L O G O U T"),
                                    textColor: Colors.white,
                                    color: Color(0xFFf7d426),
                                    onPressed: () {
//                                      signOut();
                                      print("Logout");
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        onRefresh: refreshList,
      ),
    );
  }

  void uploadimg() async {
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));

    var length = await image.length();

    var uri = Uri.parse(CommonString.api_url + "api_profile.php");

    var request = new MultipartRequest("POST", uri);

    var multipartFile = await MultipartFile("image", stream, length,
        filename: Path.basename(image.path));
    request.fields["flag"] = 9.toString();
    request.fields["userid"] = id.trim();
    request.files.add(multipartFile);

    StreamedResponse response = await request.send();

    response.stream.transform(utf8.decoder).listen((valuea) {
      print(valuea);

      var jsonData = jsonDecode(valuea);
      int value = jsonData['value'];
      var message = jsonData['message'];

      if (value == 1) {
//        updateToast(message);
        fetchData();
      } else {
//        updateToast(message);
      }
    });
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      fetchData();
    });

    return null;
  }

  TextEditingController _textGenderFieldController = TextEditingController();


  openDialogGender() {
    print("Gender");
    _displayDialogGender(context);
  }

  _displayDialogGender(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Gender'),
//            content: TextField(
//              controller: _textGenderFieldController,
//              decoration: InputDecoration(hintText: "Enter Gender"),
//              keyboardType: TextInputType.text,
//            ),
            content: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isDense: false,
                  hint: new Text(_textGenderFieldController.text),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  value: _mySelection,
                  onChanged: (String selectedStatus) {
                    setState(() {
                      _mySelection = selectedStatus;
                    });

                    _textGenderFieldController.text = selectedStatus;
                    userGender();
                  },
                  items: _myJson.map((Map map) {
                    return new DropdownMenuItem<String>(
//                              value: map["id"].toString(),
                      value: map["name"].toString(),
                      child: new Text(
                        map["name"],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  if (_textGenderFieldController.text.isEmpty) {
//                    updateToast("Gender Cant be Empty");
                    return;
                  }
//                  updateGender();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  userGender() {
    if (gendersaved == "Male") {
      print(gendersaved);
      _textGenderFieldController.text = "Male";
    } else {
      _textGenderFieldController.text = "Female";
    }
  }
}
