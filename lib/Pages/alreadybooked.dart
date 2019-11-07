import 'package:flutter/material.dart';

class AlreadyBooked extends StatefulWidget {
  @override
  _AlreadyBookedState createState() => _AlreadyBookedState();
}

class _AlreadyBookedState extends State<AlreadyBooked> {

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
   }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You have already booked a item."),
              Text("Please wait till the item is delivered to you."),
              Text("You will be able to resume booking once the items are delivered to you.")
            ],
          ),
        ),
      ),
    );
  }
}