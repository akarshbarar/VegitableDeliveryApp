import 'package:embee/Pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        //title: "",
        styleTitle:TextStyle(color: Color(0xff3da4ab), fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
       // description:"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription: TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "assets/logo.png",
        //backgroundImage:"assets/logo.jpeg" ,
        colorBegin: Colors.black,
        colorEnd: Colors.black,
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
      ),
    );
    slides.add(
      new Slide(
       // title: "MUSEUM",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description: "Eat Fresh",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "assets/logo.jpeg",
        colorBegin: Colors.black,
        colorEnd: Colors.black,
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
      ),
    );
    slides.add(
      new Slide(
       // title: "COFFEE SHOP",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:"Feel Fresh!",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
        pathImage: "assets/logo.jpeg",
        colorBegin: Colors.black,
        colorEnd: Colors.black,
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
      ),
    );
  
  }


  void onDonePress() {
    // Do what you want
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color:Colors.white,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // List slides
      slides: this.slides,
      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33000000),
      highlightColorSkipBtn: Color(0xff000000),
      // Next button
      renderNextBtn: this.renderNextBtn(),
      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33000000),
      highlightColorDoneBtn: Color(0xff000000),
      // Dot indicator
      colorDot: Colors.grey,
      colorActiveDot: Colors.white,
      sizeDot: 13.0,
      // Show or hide status bar
      shouldHideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
    );
  }
}