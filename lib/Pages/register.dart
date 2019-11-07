import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController confirmPassword=new TextEditingController();
  TextEditingController address=new TextEditingController();
  TextEditingController mobile=new TextEditingController();
  bool enabled=true,clicked=false;

  FirebaseAuth mauth=FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.reference().child('User');

addUserId(String s) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('uid', s);
}


final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
            Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green[900],
                       Colors.green[600]
                  ]
                ), 
                borderRadius:BorderRadius.only(
                  bottomLeft: Radius.circular(62.0)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person,size: 80,color: Colors.white,),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                      child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 32,bottom: 32),
                        child: Text("Login",style: TextStyle(color: Colors.white),),
                      )
                      ),
                  ),
                ],
              ),
            ),
            Form(
                key: _formKey,
                child: Container(
                height: MediaQuery.of(context).size.height/1.1,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 32.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only(top: 4.0,left: 16,right: 16,bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0
                          ),
                        ]
                      ),
                      child: TextFormField(
                        enabled: enabled,
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                            if (value.isEmpty) {
                                  return 'Please enter Email';
                            }
                             return null;
                        },
                         decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.grey,),
                        hintText: "Email",
                        fillColor: Colors.grey,
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      style: TextStyle(color: Colors.green),
                      ),
                    ),//User Id Input Field
                    Container(
                      margin: EdgeInsets.only(top: 32.0),
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only(top: 4.0,left: 16,right: 16,bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0
                          ),
                        ]
                      ),
                      child: TextFormField(
                        enabled: enabled,
                        validator: (value) {
                         if (value.isEmpty) {
                             return 'Please enter password';
                                }
                        return null;
                         },
                        controller: password,
                        obscureText: true,
                         decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.grey,),
                        hintText: "Password",
                        fillColor: Colors.grey,
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      style: TextStyle(color: Colors.green),
                      ),
                    ),//Password Input Field
                    Container(
                      margin: EdgeInsets.only(top: 32.0),
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only(top: 4.0,left: 16,right: 16,bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0
                          ),
                        ]
                      ),
                      child: TextField(
                        enabled: enabled,
                        controller: confirmPassword,
                        obscureText: true,
                         decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.grey,),
                        hintText: "Confirm Password",
                        fillColor: Colors.grey,
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      style: TextStyle(color: Colors.green),
                      ),
                    ),//Pa
                    Container(
                      margin: EdgeInsets.only(top: 32.0),
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only(top: 4.0,left: 16,right: 16,bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0
                          ),
                        ]
                      ),
                      child: TextFormField(
                       enabled: enabled,
                        validator: (value) {
                             if (value.isEmpty) {
                                return 'Please enter Address';
                              }
                                 return null;
                        },
                        controller: address,
                         decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.grey,),
                        hintText: "Address",
                        fillColor: Colors.grey,
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      style: TextStyle(color: Colors.green),
                      ),
                    ),//P
                    Container(
                      margin: EdgeInsets.only(top: 32.0),
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only(top: 4.0,left: 16,right: 16,bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0
                          ),
                        ]
                      ),
                      child: TextFormField(
                        enabled: enabled,
                        validator: (value) {
                        if (value.isEmpty) {
                           return 'Please enter Mobile';
                         }
                         return null;
                        },
                        controller: mobile,
                        keyboardType: TextInputType.phone,
                         decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.grey,),
                        hintText: "Mobile",
                        fillColor: Colors.grey,
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      style: TextStyle(color: Colors.green),
                      ),
                    ),//Pa
                    Padding(
                      padding: EdgeInsets.only(top: 32.0),
                    ),
                    button(),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      ],
      ),
    );
  }

Widget button(){
  if(clicked){
    return CircularProgressIndicator();
  }
  else{
    return GestureDetector(
                      onTap: (){
                       if (_formKey.currentState.validate()) {
                          if(password.text.toString().compareTo(confirmPassword.text.toString())==0){
                            setState(() {
                              enabled=false;
                              clicked=true;
                            });

                            signup();
                          }
                          else{
                            Fluttertoast.showToast(
                               msg: "Password Does not match",
                               toastLength: Toast.LENGTH_LONG,
                               gravity: ToastGravity.CENTER,
                               timeInSecForIos: 1,
                               backgroundColor: Colors.red,
                               textColor: Colors.white,
                               fontSize: 16.0
                           );
                          }
                        }
                      },
                        child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/1.2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green[900],
                           Colors.green[600]
                            ]
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8)
                          )
                        ),
                        child: Center(
                          child: Text(
                            "Register".toUpperCase(),
                             style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                             ),
                            ),
                        ),
                      ),
                    );

  }
}


void signup(){
   mauth.createUserWithEmailAndPassword(
        email: email.text.toString(),
        password: password.text.toString(),
    ).then((AuthResult auth){
     
           addUserId(auth.user.uid);

      ref.child(auth.user.uid).set(
          {
            'uid':auth.user.uid,
            'email':email.text.toString(),
            'password':password.text.toString(),
            'mobile':mobile.text.toString(),
            'address':address.text.toString()
          }
      );
       Navigator.of(context).pushNamed('/home');

    }
    );

}

}
