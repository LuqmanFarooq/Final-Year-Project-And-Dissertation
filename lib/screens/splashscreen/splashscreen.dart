import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/landingpage/landingpage.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  ConstantColors constantColors = ConstantColors();

  @override
  void initState() {
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: landingpage(), type: PageTransitionType.bottomToTop)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: Center(
          child: RichText(
        text: TextSpan(
            text: "the",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
            children: <TextSpan>[
              TextSpan(
                text: "Social",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: constantColors.blueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.0),
              )
            ]),
      )),
    );
  }
}
