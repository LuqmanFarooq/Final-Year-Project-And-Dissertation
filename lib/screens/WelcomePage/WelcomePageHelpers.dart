import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/WelcomePage/WelcomePageServices.dart';
import 'package:the_social/screens/WelcomePage/WelcomePageUtils.dart';

class WelcomePageHelpers with ChangeNotifier {
  Widget bodyimage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/login.jpg"))),
    );
  }

  Widget taglinetext(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return Positioned(
        top: 350,
        left: 35.0,
        child: Container(
          constraints: BoxConstraints(maxWidth: 380.0),
          child: RichText(
            text: TextSpan(
                text: "Ready ",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: constantColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                children: <TextSpan>[
                  TextSpan(
                    text: "To ",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34.0),
                  ),
                  TextSpan(
                    text: "Socialize",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.yellowColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34.0),
                  ),
                  TextSpan(
                    text: " ?",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.blackColor,
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
        top: 500.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  emailAuthSheet(context);
                },
                child: Container(
                  child: Icon(
                    EvaIcons.emailOutline,
                    color: constantColors.yellowColor,
                    size: 40,
                  ),
                  width: 250.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: constantColors.yellowColor, width: 3),
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
                "By Continuing you agree City Social's Terms of",
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

  emailAuthSheet(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: "Login Or SignUp",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.blackColor,
                  ),
                ),
                Spacer(flex: 2),
                RichText(
                  text: TextSpan(
                    text: "Already a user ? Please select SignIn",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: constantColors.blackColor,
                        child: Text('Log In',
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Provider.of<WelcomeService>(context, listen: false)
                              .loginSheet(context);
                        }),
                  ],
                ),
                Spacer(flex: 1),
                RichText(
                  text: TextSpan(
                    text: "New User select SignUp to Register",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                MaterialButton(
                    color: constantColors.redColor,
                    child: Text('Sign Up',
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Provider.of<WelcomeUtils>(context, listen: false)
                          .selectAvatarOptionssheet(context);
                    }),
                Spacer(flex: 2)
              ],
            ),
            height: MediaQuery.of(context).size.height * 50.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.yellowColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
          );
        });
  }
}
