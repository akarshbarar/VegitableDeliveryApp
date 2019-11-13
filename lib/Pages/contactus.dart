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
      appBar: AppBar(title: Text("Contact Us"),),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

            Text("Embee Foods Will be honored to help you with any problem.",style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Text("Get Connected with us via mail or Whatsapp",style: TextStyle(fontSize: 20)),
            SizedBox(height: 10,),
            Text("Our Email Address is:",style: TextStyle(fontSize: 20)),
            SizedBox(height: 10,),
            Text("contact.embee@gmail.com"),
            SizedBox(height: 10,),
            Text("Click on the chat icon to connect with us on Whataspp and our customer care represenative will reply you as soon as possibe"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var whatsappUrl ="https://wa.me/919140404277?text=Hi%I%20need%20your%20help";
          await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
        },
        child: Icon(Icons.chat),
        tooltip: "Open Whatsapp",
        foregroundColor: Colors.black,
        backgroundColor: Color.fromRGBO(37, 211, 102, 1),
      ),
      
    );
  }
}