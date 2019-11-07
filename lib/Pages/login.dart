import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  
  FirebaseAuth mauth=FirebaseAuth.instance;

  bool clicked=false;
  bool enabled=true;

addUserId(String s) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('uid', s);
}

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
              height: MediaQuery.of(context).size.height/2.5,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.person,size: 80,color: Colors.white,),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                          Navigator.of(context).pushNamed('/register');
                    },
                      child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 32,bottom: 32),
                        child: Text("Register",style: TextStyle(color: Colors.white),),
                      )
                      ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/2,
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
                      validator: (value) {
                        if (value.isEmpty) {
                           return 'Please enter Email';
                         }
                         return null;
                      },
                      enabled: enabled,
                      cursorColor: Colors.green,
                      controller: email,
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
                      validator: (value) {
                        if (value.isEmpty) {
                           return 'Please enter Password';
                         }
                         return null;
                        },
                      enabled: enabled,
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.security,color: Colors.grey,),
                        hintText: "Password",
                         fillColor: Colors.grey,
                        hintStyle: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      style: TextStyle(color: Colors.green),
                    ),
                  ),//Password Input Field
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 32
                      ),
                      child: GestureDetector(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.grey
                            ),
                          ),
                          onTap: (){

                          },
                        ),
                    ),
                  ),
                  Spacer(),
                  button(),
                  
                ],
              ),
            ),
          ],
        ),
      )
      ],
      ),
    );
  }

  signin() async{
    String Email=email.text;
    String Password=password.text;
    await mauth.signInWithEmailAndPassword(
        email: Email,
        password: Password,
    ).then((AuthResult auth){
      addUserId(auth.user.uid);
      Navigator.pushNamed(context, '/home');
    })
    .catchError((e)=>print(e));
  }

  Widget button(){
  if(clicked){
    setState(() {
      enabled=!enabled;
    });
    return CircularProgressIndicator();
  }
  else{
    return GestureDetector(
                      onTap: (){
                        setState(() {
                           clicked=true;
                        });
                        signin();
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
                            "Login".toUpperCase(),
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

}

