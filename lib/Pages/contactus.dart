import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  
   
  var phone="919140404277";
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text("About Us"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Text("Contact Us"),
            FlatButton(
            child: Text("Open WhatsApp"),
            onPressed: () async {
              var whatsappUrl ="https://wa.me/919140404277?text=Hi%I%20need%20your%20help";
              await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
            },
          ),
          Text("contact.embee@gmail.com")
        ],
      ),
      
    );
  }
}