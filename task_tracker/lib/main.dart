import 'package:flutter/material.dart';
import 'package:tasktracker/screens/home_screen.dart';
import 'package:tasktracker/screens/view_tasks.dart';

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
                fontSize: 16.0,
              ),
              body1: TextStyle(
                  fontFamily: 'Muli', color: Colors.white, fontSize: 14.0))),
      home: HomeScreen(),
    ));
