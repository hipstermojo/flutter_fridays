import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Task Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF333839),
          accentColor: Color(0xFFFC1607),
          textTheme: TextTheme(
              title: TextStyle(
                fontFamily: 'IBM Plex Serif',
                color: Colors.white,
                fontSize: 20.0,
              ),
              body1: TextStyle(
                  fontFamily: 'Muli', color: Colors.white, fontSize: 18.0))),
      home: Scaffold(
        body: Center(
          child: Text('Task Tracker'),
        ),
      ),
    ));
