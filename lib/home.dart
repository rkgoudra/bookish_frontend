import 'package:bookish/CommonString.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;

  MainMenu(this.signOut);

  @override
  _MainMenuState createState() => _MainMenuState();
  List<Widget> containers = [
    Container(
      color: Colors.pink,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.deepPurple,
    )
  ];
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  int currentIndex = 0;
  String selectedIndex = 'TAB: 0';

  String email = "",
      name = "",
      id = "";
  TabController tabController;

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
return Scaffold(
//      appBar: AppBar(
//        actions: <Widget>[
//          IconButton(
//            onPressed: () {
//              signOut();
//            },
//            icon: Icon(Icons.lock_open),
//          )
//        ],
//      ),
//      body: Center(
//        child: Text(
//          "WelCome",
//          style: TextStyle(fontSize: 30.0, color: Colors.blue),
//        ),
//      ),
//    );
//  }
  appBar: AppBar(

    elevation: 30.0,
    title:Text("BOOKISH"),
    centerTitle: true,

    backgroundColor: Color(CommonString.btn_color),
      actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.lock_open),
          )
        ],
  ),

  body: Form(
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
      ),
    ),

  ),
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: 0, // this will be set when a new tab is tapped

    items: [
      BottomNavigationBarItem(
        icon: new Icon(Icons.home),
        title: new Text('Home'),

      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.book),
        title: new Text('Books'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile')
      )
    ],
  ),
);
  }
}