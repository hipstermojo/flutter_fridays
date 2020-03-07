import 'package:flutter/material.dart';

import 'package:tasktracker/widgets/time_range.dart';

class CreateTask extends StatelessWidget {
  final List<String> _categories = [
    'Project',
    'Event',
    'Meeting',
    'Personal',
    'Other'
  ];

  final List<String> _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Create New Task',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 24.0),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.title,
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.body1,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[600])),
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                          isDense: true,
                          hintStyle: Theme.of(context).textTheme.body1.copyWith(
                                color: Colors.grey[600],
                              ),
                          hintText: 'Team Meeting. Creative Brainstorm.'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.title,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[600])),
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                          isDense: true,
                          hintStyle: Theme.of(context).textTheme.body1.copyWith(
                                color: Colors.grey[600],
                              ),
                          hintText: 'Kick off with Michael team.'),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          'Edit',
                          style: Theme.of(context).textTheme.body1.copyWith(
                              fontSize: 16.0, color: Colors.grey[600]),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Wrap(
                        children: _categories
                            .map((category) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          width: 1.0, color: Colors.grey[600])),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  margin:
                                      EdgeInsets.only(right: 5.0, bottom: 5.0),
                                  child: Text(
                                    category,
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(color: Colors.grey[600]),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                      color: Colors.grey[600],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Tags',
                            style: Theme.of(context).textTheme.title,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 0.0,
                      color: Colors.grey[600],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 25.0, bottom: 15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Date',
                                style: Theme.of(context).textTheme.title,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Jan 13-Jan 25',
                                    style: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(fontSize: 15.0),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey[600],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _days
                          .map((day) => Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.grey[600]),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  day,
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .copyWith(color: Colors.grey[600]),
                                ),
                                alignment: Alignment.center,
                              ))
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Time range',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Switch(
                          value: true,
                          onChanged: (bool value) {
                            print(value);
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TimeRange(),
                    SizedBox(
                      height: 40.0,
                    )
                  ],
                ),
              ),
              Container(
                height: 100.0,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xFFFC1607),
                      ),
                      child: Text(
                        'Create',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      height: 40.0,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Go back');
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                width: 2.0, color: Colors.grey[600])),
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
