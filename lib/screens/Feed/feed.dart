import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Feed/feedhelpers.dart';

class Feed extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.blackColor,
      drawer: Drawer(),
      appBar: Provider.of<FeedHelpers>(context, listen: false).appBar(context),
      body: Provider.of<FeedHelpers>(context, listen: false).feedBody(context),
    );
  }
}
