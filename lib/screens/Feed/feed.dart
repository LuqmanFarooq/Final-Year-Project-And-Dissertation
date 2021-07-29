import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Feed/feedhelpers.dart';

class feed extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.blackColor,
      drawer: Drawer(),
      appBar: Provider.of<feedhelpers>(context, listen: false).appBar(context),
      body: Provider.of<feedhelpers>(context, listen: false).feedBody(context),
    );
  }
}
