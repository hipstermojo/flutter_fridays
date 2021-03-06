import 'package:dial/models/travel_stats.dart';
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final boldStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  var current = 2;
  double opacity = 1.0;
  Stats stats;
  @override
  void initState() {
    super.initState();
    stats = stats = Stats(current);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: opacity,
            child: Column(
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
                        "$current Days",
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
                        "${stats.duration.inHours} hours ${stats.duration.inMinutes % 60} minutes",
                        style: boldStyle,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("On some days, you'll have to climb over"),
                      Text(
                        "${stats.distance} metres",
                        style: boldStyle,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("The overall difficulty level is"),
                      Text(
                        "${stats.difficulty}",
                        style: boldStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Dial(
            from: 2,
            to: 25,
            onUpdate: (value) {
              setState(() {
                current = value;
              });
            },
            onStart: () {
              setState(() {
                opacity = 0.1;
              });
            },
            onComplete: (newDay) {
              setState(() {
                stats = Stats(newDay);
                opacity = 1.0;
              });
            },
          ),
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
                Text("${Stats.TOTAL_DURATION.inHours}h ${Stats.TOTAL_DURATION.inMinutes%60}m"),
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
                  Text("${Stats.ASCENT}m")
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
