import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Text("We are agribusiness Professionals having a combined experience of more than 35 years in the relevant field. Having exposure into both domestic and international market. We have the understanding of the need of our customers and have the expertise to live up to their expectations"),
        ],
      ),
      
    );
  }
}