import 'package:avatar_glow/avatar_glow.dart';
import 'package:bookish/CommonString.dart';
import 'package:bookish/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String email = "", name = "", id = "";

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
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              width: SizeConfig.safeBlockHorizontal * 100,

            ),
            new Positioned(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: SizeConfig.safeBlockHorizontal * 100,

//                      color: Color(CommonString.background_color),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://linkedinbackground.com/download/xAlways-Neat.jpg.pagespeed.ic.lEwnm6dO4Y.webp'),
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                        ),
                      ),

                      child: Column(
                        children: <Widget>[
                          AvatarGlow(
                            startDelay: Duration(milliseconds: 1000),
                            glowColor: Colors.deepOrange,
                            endRadius: 120.0,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 100),
                            child: Material(
                              elevation: 8.0,
                              shape: CircleBorder(),
                              color: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage: //AssetImage('assets/book.png'),
                                NetworkImage('https://media.licdn.com/dms/image/C5103AQH5X3KewPsp4A/profile-displayphoto-shrink_200_200/0?e=1579132800&v=beta&t=iwoSmVJ89fmK8rq7oNUfKwp1uf6gFPhOJRqtVA4NPPY'),
                                radius: 60.0,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Positioned(

                bottom: SizeConfig.safeBlockHorizontal * 75,
                left: SizeConfig.safeBlockHorizontal * 10,
                child: Container(
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),

                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    " Total Books",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Lent",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Borrowed",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                )),

        new Positioned.fill(
                    top: SizeConfig.safeBlockVertical * 44,
          child: Align(
            alignment: Alignment.center,

            child:
            Container(
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Text(
                    "Howdy",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    "bookish @",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),

                ],
              ),
            ),
            ),
            ),

          ],
        ),
      ),
    );
  }
}
