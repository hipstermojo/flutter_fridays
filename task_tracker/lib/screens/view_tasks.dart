import 'package:flutter/material.dart';
import 'package:tasktracker/screens/create_task.dart';
import 'package:tasktracker/widgets/task_tile.dart';

class ViewTasks extends StatelessWidget {
  final List<String> _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

  final Widget customDot = Container(
    height: 2.0,
    width: 2.0,
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    margin: EdgeInsets.symmetric(horizontal: 1.5, vertical: 5.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30.0))),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back,
                            color: Colors.grey[600],
                          ),
                          Text(
                            'Design Festival 2019',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(fontSize: 22.0),
                          ),
                          Text(
                            'Edit',
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.grey[600]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      40.0, 0.0, 40.0, 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: _months
                                        .map((month) => Text(
                                              month,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[600]),
                                            ))
                                        .toList(),
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).accentColor),
                                child: Column(
                                  // Contents of the circle
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      'Total time',
                                      style: Theme.of(context)
                                          .textTheme
                                          .body1
                                          .copyWith(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      '216 hours',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(fontSize: 20.0),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.filled(3, customDot),
                                    ),
                                    Text(
                                      '27 tasks completed',
                                      style: Theme.of(context)
                                          .textTheme
                                          .body1
                                          .copyWith(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Tasks',
                            style: Theme.of(context).textTheme.title.copyWith(
                                color: Theme.of(context).accentColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.tune,
                            size: 16.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 4,
                        itemBuilder: (BuildContext _, int index) {
                          return TaskTile();
                        }),
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home),
                  GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CreateTask())),
                      child: Icon(Icons.add_circle_outline)),
                  Icon(Icons.calendar_today)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
