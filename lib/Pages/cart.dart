import 'dart:io';

import 'package:embee/model/fooditems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mailer2/mailer.dart';


class CartIndex extends StatefulWidget {

  List<FoodItem> foodItems;
  List<int> quantity;
    CartIndex({Key key,@required this.foodItems,@required this.quantity}):super(key: key);
  @override
  _CartIndexState createState() => _CartIndexState(
    foodItems:foodItems,
    quantity:quantity
  );
}

class _CartIndexState extends State<CartIndex> {

  List<FoodItem> foodItems;
  List<int> quantity;
    _CartIndexState({@required this.foodItems,@required this.quantity});
 
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference ref;
  String uid,currentUserEmail;

  int totalPrice=0;
    List<String> titleNew=List();
    List<String> priceNew=List();
    List<int> quantityNew=List();


  getUid() async {
   final id=await FirebaseAuth.instance.currentUser();
     uid=id.uid; 
     currentUserEmail=id.email;
     print(uid);
     print(currentUserEmail);
   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
    ref=_database.reference();

    int priceOfFood=0;
    for(int i=0;i<foodItems.length;i++){
      print(foodItems[i].title);
      print(foodItems[i].price);
      print(quantity[i]);
      titleNew.add(foodItems[i].title);
      priceNew.add(foodItems[i].price.toString());
      quantityNew.add(quantity[i]);
      priceOfFood+=(quantity[i]*foodItems[i].price);
    }
    setState(() {
      totalPrice=priceOfFood;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Container(
            height:500.0 ,
            
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: foodItems.length,
                itemBuilder: (context,index){
                  return tiles(foodItems[index],quantity[index].toString());
                },
              ),
            
          ),
           InkWell(
            onTap: (){},
            child: Container(
            width: MediaQuery.of(context).size.width,
            height: 55.0,
              decoration: BoxDecoration(
              gradient: LinearGradient(
                    colors: [
                              Colors.green[900],
                              Colors.green[600]
                            ]),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              FirebaseDatabase _database = FirebaseDatabase.instance;
                            
                              _database.reference().child("Order").child(uid).push().set({
                                  "title":titleNew,
                                  "price":priceNew,
                                  "quantity":quantityNew,
                                  "totalPrice":totalPrice,
                              });
                            
                              sendMail(currentUserEmail, titleNew,priceNew,quantityNew,totalPrice);
                              Navigator.of(context).pushNamed("/last");
                            },
                            child: Center(
                              child: Text("Total Payable Amount is::"+totalPrice.toString()),
                              
                            ),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
      
    );
  }


  Widget tiles(FoodItem k,String v){
    return Card(
        borderOnForeground: true,
        semanticContainer: true,
        //color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  
              ],
          ),
          Text("Item::"+k.title,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
          Text("Quantity::"+v,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
          Text("Price/Kg::₹"+k.price.toString(),style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
          ],
        ),
    );
      //return Text(k.title+" "+v+"::"+k.price.toString(),style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),);
  }

  sendMail(String email, List titleList,List priceList,List quantityList,int price){
    var options = new GmailSmtpOptions()
    ..username = 'mrinal.embee@gmail.com'
    ..password = 'cuinhell'; 

    String s="";

          for(int i=0;i<titleList.length;i++){
            s=s+"<tr><td style='border: 1px solid black ;'>"+(i+1).toString()+"</td>"+"<td style='border: 1px solid black ;'>"+titleList[i].toString()+"</td>"+"<td style='border: 1px solid black ;'>"+priceList[i].toString()+"</td>"+"<td style='border: 1px solid black ;'>"+quantityList[i].toString()+"</td>"+"</tr>";
          }     
          s="<table style='border: 1px solid black;'><tr><th style='border: 1px solid black ;'>SNo.</th><th style='border: 1px solid black ;'>Items</th><th style='border: 1px solid black ;'>Price/kg</th><th style='border: 1px solid black ;'>Quantity</th></tr>"+s+"</table>";     
          String htmlText='<h1>Embee Food</h1><br><p>Hey Your Order is <h3>'+s+'</h3>has been recieved our representative will bring the food to you. <br> Total Amout to be paid is <h3>$price</h3></p><br><p> Thank You</p>';
                    
  // How you use and store passwords is up to you. Beware of storing passwords in plain.
  // Create our email transport.
  var emailTransport = new SmtpTransport(options);
  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'mrinal.embee@gmail.com'
    ..recipients.add(email)
    ..bccRecipients.add('csreplyhelp@gmail.com')
    ..subject = 'Embee Order'+DateTime.now().toString()
    ..text = 'Embee Food Order Summery'
    ..html = htmlText;
  // Email it.
  emailTransport.send(envelope)
    .then((envelope) => print('Email sent!'))
    .catchError((e) => print('Error occurred: $e'));
  }
}
