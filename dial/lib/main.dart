import 'package:dial/widgets/Dial.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final boldStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "21 Days",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold),
                      ),
                      CircleAvatar(
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("On average you need to ride"),
                      Text(
                        "2 hours 10 minutes",
                        style: boldStyle,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("On some days, you'll have to climb over"),
                      Text(
                        "466 metres",
                        style: boldStyle,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("The overall difficulty level is"),
                      Text(
                        "Intermediate",
                        style: boldStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Color(0xAAFFFFFF),
              ),
            ),
          ],
        ),
        Expanded(
          child: Dial()
        ),
        Container(
          height: 60.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                Icon(Icons.timer),
                SizedBox(
                  height: 3.0,
                ),
                Text("45h 42m"),
              ]),
              Column(
                children: <Widget>[
                  Icon(Icons.directions_bike),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text("960km")
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.arrow_upward),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text("9780m")
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.arrow_downward),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text("11470m")
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
