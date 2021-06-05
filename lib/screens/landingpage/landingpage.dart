import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/landingpage/landinghelpers.dart';

class landingpage extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColors.whiteColor,
        body: Stack(
          children: [
            bodycolor(),
            Provider.of<landinghelpers>(context, listen: false)
                .bodyimage(context),
            Provider.of<landinghelpers>(context, listen: false)
                .taglinetext(context),
            Provider.of<landinghelpers>(context, listen: false)
                .mainbutton(context),
            Provider.of<landinghelpers>(context, listen: false)
                .privacytext(context),
          ],
        ));
  }

  bodycolor() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.5,
            0.9
          ],
              colors: [
            constantColors.darkColor,
            constantColors.blueGreyColor,
          ])),
    );
  }
}
