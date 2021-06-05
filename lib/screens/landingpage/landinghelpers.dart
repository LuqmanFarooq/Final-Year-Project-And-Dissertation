import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';

class landinghelpers with ChangeNotifier {
  Widget bodyimage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/login.png"))),
    );
  }

  Widget taglinetext(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return Positioned(
        top: 450,
        left: 10.0,
        child: Container(
          constraints: BoxConstraints(maxWidth: 170.0),
          child: RichText(
            text: TextSpan(
                text: "Are ",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: constantColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                children: <TextSpan>[
                  TextSpan(
                    text: "You ",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34.0),
                  ),
                  TextSpan(
                    text: "Social",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34.0),
                  ),
                  TextSpan(
                    text: " ?",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34.0),
                  )
                ]),
          ),
        ));
  }

  Widget mainbutton(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return Positioned(
        top: 630.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Container(
                  child: Icon(
                    EvaIcons.emailOutline,
                    color: constantColors.yellowColor,
                  ),
                  width: 80.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.yellowColor),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              GestureDetector(
                child: Container(
                  child: Icon(
                    EvaIcons.facebookOutline,
                    color: constantColors.blueColor,
                  ),
                  width: 80.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.blueColor),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              GestureDetector(
                child: Container(
                  child: Icon(
                    EvaIcons.googleOutline,
                    color: constantColors.redColor,
                  ),
                  width: 80.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.redColor),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ],
          ),
        ));
  }

  Widget privacytext(BuildContext context) {
    return Positioned(
        top: 690.0,
        left: 20.0,
        right: 20.0,
        child: Container(
          child: Column(
            children: [
              Text(
                "By Continuing you agree theSocial's Terms of",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
              ),
              Text(
                "Services & Privacy Policy",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
              )
            ],
          ),
        ));
  }
}
