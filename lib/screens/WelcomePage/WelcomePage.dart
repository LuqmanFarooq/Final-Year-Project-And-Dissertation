import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/WelcomePage/WelcomePageHelpers.dart';

class WelcomePage extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Do you want to exit the app?"),
                actions: <Widget>[
                  TextButton(
                    child: Text("No"),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () => exit(0),
                  )
                ],
              ));
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: constantColors.whiteColor,
          body: Stack(
            children: [
              bodycolor(),
              Provider.of<WelcomePageHelpers>(context, listen: false)
                  .bodyimage(context),
              Provider.of<WelcomePageHelpers>(context, listen: false)
                  .taglinetext(context),
              Provider.of<WelcomePageHelpers>(context, listen: false)
                  .mainbutton(context),
              Provider.of<WelcomePageHelpers>(context, listen: false)
                  .privacytext(context),
            ],
          )),
    );
  }

  bodycolor() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            1.0,
            1.0
          ],
              colors: [
            constantColors.whiteColor,
            constantColors.blueGreyColor,
          ])),
    );
  }
}
