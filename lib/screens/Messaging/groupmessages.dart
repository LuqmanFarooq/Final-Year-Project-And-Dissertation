import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Chatroom/chatroom.dart';
import 'package:the_social/screens/Homepage/homepage.dart';
import 'package:the_social/screens/Messaging/groupmessageshelper.dart';

class GroupMessages extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  final DocumentSnapshot documentSnapshot;
  GroupMessages({@required this.documentSnapshot});
  TextEditingController messageControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context,
          PageTransition(
              child: ChatRoom(), type: PageTransitionType.bottomToTop)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: constantColors.whiteColor,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: HomePage(),
                        type: PageTransitionType.bottomToTop));
              }),
          centerTitle: true,
          backgroundColor: constantColors.yellowColor.withOpacity(0.2),
          title: Text(documentSnapshot['chatroomname']),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                AnimatedContainer(
                    child: Provider.of<GroupMessagingHelper>(context,
                            listen: false)
                        .showmessages(context, documentSnapshot),
                    duration: Duration(seconds: 1),
                    curve: Curves.bounceIn,
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: messageControler,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Enter message here...',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.amber.withOpacity(0.2),
                        onPressed: () {
                          if (messageControler.text.isNotEmpty) {
                            Provider.of<GroupMessagingHelper>(context,
                                    listen: false)
                                .sendMessage(context, documentSnapshot,
                                    messageControler);
                          }
                        },
                        child: Icon(
                          Icons.send_sharp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
