import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Messaging/groupmessages.dart';
import 'package:the_social/Backend/authentication.dart';
import 'package:the_social/Backend/firebaseoperations.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatRoomHelpers with ChangeNotifier {
  String chatroomId;
  String get getChatroomId => chatroomId;

  String imageTimePosted;
  String get getImageTimePosted => imageTimePosted;

  showTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    imageTimePosted = timeago.format(dateTime);
    print(imageTimePosted);
    notifyListeners();
  }

  ConstantColors constantColors = ConstantColors();
  final TextEditingController chatnameController = TextEditingController();
  showCreateChatroomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    color: constantColors.blackColor,
                    thickness: 4.0,
                  ),
                ),
                Text(
                  'Chat Room Creation',
                  style: TextStyle(
                      color: constantColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 200,
                      child: TextField(
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            hintText: 'Enter Chatroom ID',
                            hintStyle: TextStyle(
                                color: constantColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                        controller: chatnameController,
                        style: TextStyle(
                            color: constantColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Provider.of<FirebaseOpertrations>(context,
                                listen: false)
                            .submitChatroomData(chatnameController.text, {
                          'chatroomname': chatnameController.text,
                          'username': Provider.of<FirebaseOpertrations>(context,
                                  listen: false)
                              .initUserName,
                          'userimage': Provider.of<FirebaseOpertrations>(
                                  context,
                                  listen: false)
                              .initUserImage,
                          'useremail': Provider.of<FirebaseOpertrations>(
                                  context,
                                  listen: false)
                              .initUserEmail,
                          'useruid': Provider.of<Authentication>(context,
                                  listen: false)
                              .getUserid,
                          'time': Timestamp.now()
                        }).whenComplete(() {
                          chatnameController.clear();
                          Navigator.pop(context);
                        });
                      },
                      backgroundColor: constantColors.blackColor,
                      child: Icon(
                        FontAwesomeIcons.plus,
                        size: 25,
                        color: constantColors.yellowColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.90,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.yellowColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
          );
        });
  }

  showchatrooms(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('chatrooms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children:
                  snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                Provider.of<ChatRoomHelpers>(context, listen: false)
                    .showTimeAgo(documentSnapshot['time']);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: GroupMessages(
                                    documentSnapshot: documentSnapshot),
                                type: PageTransitionType.bottomToTop));
                      },
                      leading: Icon(Icons.message_outlined),
                      title: Text(
                        documentSnapshot['chatroomname'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '${Provider.of<ChatRoomHelpers>(context, listen: false).getImageTimePosted.toString()}'),
                      //tileColor: Colors.white,
                    ),
                  ),
                );
              }).toList(),
            );
          }
        });
  }
}
