import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flutter/material.dart';


class LastPage extends StatefulWidget {
  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
static final double containerSize = 20.0;
  // Wheather this element is a favorite or not.

  @override
  Widget build(BuildContext context) {

      return SafeArea(

        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: FlareActor(
                      "assets/SuccessCheck.flr",
                        animation: "show",
                    ),
                  ),
                  Text(
                    "Your Order has been placed, You will recieve a mail regarding your booking",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
  }
}
    