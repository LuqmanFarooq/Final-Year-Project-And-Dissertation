import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Chatroom/chatroomhelpers.dart';

class chatroom extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<chatroomhelpers>(context, listen: false)
              .showCreateChatroomSheet(context);
        },
        backgroundColor: constantColors.yellowColor,
        child: Icon(
          FontAwesomeIcons.plus,
          size: 25,
          color: constantColors.blackColor,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert_outlined,
                color: constantColors.whiteColor,
              ),
              onPressed: () {})
        ],
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.plus,
              size: 25,
              color: constantColors.yellowColor,
            ),
            onPressed: () {
              Provider.of<chatroomhelpers>(context, listen: false)
                  .showCreateChatroomSheet(context);
            }),
        backgroundColor: constantColors.yellowColor.withOpacity(0.2),
        title: RichText(
            text: TextSpan(
                text: "Chat ",
                style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                children: <TextSpan>[
              TextSpan(
                text: 'Social',
                style: TextStyle(
                  color: constantColors.yellowColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              )
            ])),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Provider.of<chatroomhelpers>(context, listen: false)
            .showchatrooms(context),
      ),
    );
  }
}
