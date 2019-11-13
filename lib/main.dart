import 'dart:async';

import 'package:embee/provider/networkprovider.dart';
import 'package:embee/theme/customtheme.dart';
import 'package:embee/theme/mythemes.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:embee/Pages/home.dart';
import 'package:embee/Pages/lastPage.dart';
import 'package:embee/Pages/login.dart';
import 'package:embee/Pages/register.dart';
import 'package:embee/Pages/sliderPage.dart';
import 'package:embee/Pages/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
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
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stream Provider Demo',
      theme:CustomTheme.of(context),
      routes: {
        '/slider':(context)=>SliderPage(),
        '/splash':(context)=>SplashScreen(),
        '/last':(context)=>LastPage(),
        '/login':(context)=>LoginPage(),
        '/register':(context)=>RegisterPage(),
        '/home':(context)=>HomePage(),
      },
      home: Scaffold(
        
        body: Provider<NetworkProvider>(
          builder: (context) => NetworkProvider(),
          child: Consumer<NetworkProvider>(
            builder: (context, value, _) => Center(
              child: NetworkStatusBasedWidget(
                networkProvider: value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NetworkStatusBasedWidget extends StatefulWidget {
  final NetworkProvider networkProvider;

  NetworkStatusBasedWidget({@required this.networkProvider});

  @override
  _NetworkStatusBasedWidgetState createState() =>
      _NetworkStatusBasedWidgetState();
}

class _NetworkStatusBasedWidgetState extends State<NetworkStatusBasedWidget> {
  @override
  void dispose() {
    widget.networkProvider.disposeStreams();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>.value(
      value: widget.networkProvider.networkStatusController.stream,
      child: Consumer<ConnectivityResult>(
        builder: (context, value, _) {
          if (value == null) {
            return Container();
          }
          if(value==ConnectivityResult.none){
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("No Internet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,),),
                          Container(
                            height: 400.0,
                            width: 400.0,
                            child: FlareActor(
                              "assets/noInternet.flr",
                              animation: "show",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }
          if(value!=ConnectivityResult.none){
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

          return Text(
            "You are ${(value != ConnectivityResult.none) ? "online" : "offline"} now",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Embee App",
//       theme: 

//       home: CheckPage(),
//     );
//   }
// }

// class CheckPage extends StatefulWidget {
//   @override
//   _CheckPageState createState() => _CheckPageState();
// }

// class _CheckPageState extends State<CheckPage> {

//   var _connectionStatus='Unknown';
//   Connectivity connectivity;
//   StreamSubscription<ConnectivityResult> subscription;


//   @override
//   void initState()  {
//     super.initState();
//     connectivity=Connectivity();
//     subscription=connectivity
//         .onConnectivityChanged
//         .listen((ConnectivityResult result){
//             print(result);
//             if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){
//               _connectionStatus="Connected";
//             }
//             else{
//               _connectionStatus="NotConnected";
//             }
//          });
//   }
//   @override
//   void dispose(){
//     super.dispose();
//     subscription?.cancel();
//   }
//   @override
//   Widget build(BuildContext context) {
//     if(_connectionStatus=="Connected"){
//       return FutureBuilder<FirebaseUser>(
//           future: FirebaseAuth.instance.currentUser(),
//           builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
//             if (snapshot.hasData){
//               FirebaseUser user = snapshot.data; // this is your user instance
//               /// is because there is user already logged
//               return HomePage();
//             }
//             /// other way there is no user logged.
//             return SliderPage();
//           }
//       );
//     }
//     else{
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text("No Internet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,),),
//               Container(
//                 height: 400.0,
//                 width: 400.0,
//                 child: FlareActor(
//                   "assets/noInternet.flr",
//                   animation: "show",
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//   }
// }


