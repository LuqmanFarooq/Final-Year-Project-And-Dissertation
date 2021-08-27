import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/WelcomePage/WelcomePage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

//this is splash screen here we have used an animation and added some timer
//so after some time period the app navigates to next screen
class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  ConstantColors constantColors = ConstantColors();

  @override
  void initState() {
    // using the timer function to auto navigate to the next page after specified time amount
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: WelcomePage(), type: PageTransitionType.bottomToTop)));
    super.initState();
  }

// splash widget using TypewriterAnimatedText of animated_text_kit library
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColors.darkColor,
        body: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'City Social',
                speed: const Duration(milliseconds: 150),
                textStyle: TextStyle(
                    fontFamily: 'Poppins',
                    color: constantColors.yellowColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
            ],
          ),
        ));
  }
}
