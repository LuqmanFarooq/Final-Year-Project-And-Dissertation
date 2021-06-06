import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';

class homepage extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.redColor,
    );
  }
}
