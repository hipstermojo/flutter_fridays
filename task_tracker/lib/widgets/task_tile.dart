import 'package:flutter/material.dart';
import 'package:tasktracker/widgets/custom_action_chip.dart';

class TaskTile extends StatefulWidget {
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  double _leftPos = 0.0;
  double _borderRadius = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 60.0,
                  color: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 100.0,
                  width: 60.0,
                  color: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            left: _leftPos,
            curve: Curves.easeInOut,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(_borderRadius))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      '14:27',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'UI. Inner pages: About, Company, Blog, Solutions',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Expanded(
                            child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.filled(
                              40,
                              CustomActionChip(
                                onPressed: null,
                                label: 'Project',
                                backgroundColor: Colors.white,
                                borderColor: Colors.grey[600],
                                labelStyle: TextStyle(color: Colors.grey[600]),
                              )),
                        )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_leftPos == 0.0) {
                          _leftPos = -120.0;
                          _borderRadius = 10.0;
                        } else {
                          _borderRadius = _leftPos = 0.0;
                        }
                      });
                    },
                    child: Container(
                      child: Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
