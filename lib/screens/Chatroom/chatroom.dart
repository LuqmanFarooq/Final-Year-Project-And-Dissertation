import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Chatroom/chatroomhelpers.dart';
import 'package:the_social/screens/Homepage/homepage.dart';

//here is chatroom class in this class we have a button through which we can create a chatroom.
//plus we have a list of all chatrooms till now thats what this class is all about
class ChatRoom extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context,
          PageTransition(
              child: HomePage(), type: PageTransitionType.bottomToTop)),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //here using provider we call the "showCreateChatroomSheet" to create a bottom sheet that we created in chatroom helper.
            Provider.of<ChatRoomHelpers>(context, listen: false)
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
                Provider.of<ChatRoomHelpers>(context, listen: false)
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
        //here in the body we have a list of chatrooms
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Provider.of<ChatRoomHelpers>(context, listen: false)
              .showchatrooms(context),
        ),
      ),
    );
  }
}
