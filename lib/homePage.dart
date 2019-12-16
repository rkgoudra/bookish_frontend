import 'dart:ui' as prefix0;

import 'package:bookish/sizeconfig.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1476275466078-4007374efbbe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1490633874781-1c63cc424610?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1558901357-ca41e027e43a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1542012204088-49fc1ae18754?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
];

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  imgList,
      (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.network(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'During a conversation, listening is as powerful as loving',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          imgList,
              (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),
    ]);
  }
}
//
class CarouselDemo extends StatelessWidget {
  dynamic iconName1, iconName2,iconName3, iconName4;
  @override
  Widget build(BuildContext context) {
    final CarouselSlider manualCarouselDemo = CarouselSlider(
      items: child,
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(

          children: <Widget>[
           Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(children: [
                  CarouselWithIndicator(),
                  Visibility(
                    visible: false,
                    child: Column(
                      children: <Widget>[
                        iconName1=IconButton(

                          // Use the string name to access icons.
                            icon: Icon(Icons.add_circle,color:Colors.white,),

                            onPressed: () { print('Using the sword'); }
                        ),
                        iconName2=IconButton(

                          // Use the string name to access icons.
                            icon: Icon(Icons.style,color:Colors.white,),

                            onPressed: () { print('Using the sword'); }
                        ),
                        iconName3=IconButton(

                          // Use the string name to access icons.
                            icon: Icon(Icons.library_books,color:Colors.white,),

                            onPressed: () { print('Using the sword'); }
                        ),
                        iconName4=IconButton(

                          // Use the string name to access icons.
                            icon: Icon(Icons.settings,color:Colors.white,),

                            onPressed: () { print('Using the sword'); }
                        ),

                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      commonCardDesign("Add Books",iconName1),

                      commonCardDesign("Borrowed Books",iconName2),
                    ],
                  ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      commonCardDesign("Lent Books",iconName3),

                      commonCardDesign("Settings",iconName4),
                    ],
                  ),
                ])),
          ],

        ),
      ),
    );
  }
  commonCardDesign(String cardName, dynamic iconName){
    return
    Card(
      elevation: 4.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color:Colors.blueGrey,
      child: new InkWell(
        onTap: () {
          print("tapped");
        },
        child: Container(
          width: SizeConfig.screenWidth*0.45,
          height: SizeConfig.screenHeight*0.20,
          child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
//            child: Text('$cardName', style: TextStyle(
//              color:Colors.white,
//
//            ),
//            ),
            children: <Widget>[
            iconName,

           Text('$cardName', style:TextStyle(color: Colors.white),),
          ],
          ),
          ),
        ),
      ),
    );
  }
}

