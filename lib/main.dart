import 'package:embee/theme/customtheme.dart';
import 'package:embee/theme/mythemes.dart';
import 'package:flutter/material.dart';
import 'package:embee/Pages/home.dart';
import 'package:embee/Pages/lastPage.dart';
import 'package:embee/Pages/login.dart';
import 'package:embee/Pages/register.dart';
import 'package:embee/Pages/sliderPage.dart';
import 'package:embee/Pages/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
 * Embee Android App for Embee Incorporation
 * @author: Akarsh Barar(CodeCave)
 * Starting Date: 27/08/2019
 */

void main() {
  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Embee App",
      theme: CustomTheme.of(context),
      routes: {
        '/slider':(context)=>SliderPage(),
        '/splash':(context)=>SplashScreen(),
        '/last':(context)=>LastPage(),
        '/login':(context)=>LoginPage(),
        '/register':(context)=>RegisterPage(),
        '/home':(context)=>HomePage(),
      },
      home: CheckPage(),
    );
  }
}

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {

  @override
  void initState() {
    super.initState();
    // if (FirebaseAuth.instance.currentUser() != null) {
    //     Navigator.of(context).pushNamed("/home");
    // } else {
    //  Navigator.of(context).pushNamed("/splash"); 
    // }
  }
  @override
  Widget build(BuildContext context) {
         return FutureBuilder<FirebaseUser>(
            future: FirebaseAuth.instance.currentUser(),
            builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
                       if (snapshot.hasData){
                           FirebaseUser user = snapshot.data; // this is your user instance
                           /// is because there is user already logged
                           return HomePage();
                        }
                         /// other way there is no user logged.
                         return SliderPage();
             }
          );
  }
}


