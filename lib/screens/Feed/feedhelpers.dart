import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/utils/uploadpost.dart';

class feedhelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: constantColors.darkColor.withOpacity(0.6),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.camera_enhance_rounded,
              color: constantColors.greenColor,
            ),
            onPressed: () {
              Provider.of<uploadpost>(context, listen: false)
                  .selectpostImageType(context);
            })
      ],
      title: RichText(
          text: TextSpan(
              text: "Social ",
              style: TextStyle(
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              children: <TextSpan>[
            TextSpan(
              text: 'Feed',
              style: TextStyle(
                color: constantColors.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            )
          ])),
    );
  }

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0)))),
      ),
    );
  }
}
