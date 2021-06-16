import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: PageView(
        controller: homepageController,
        children: [],
      ),
    );
  }
}
