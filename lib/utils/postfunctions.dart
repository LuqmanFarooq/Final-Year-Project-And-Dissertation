import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebaseoperations.dart';
import 'package:timeago/timeago.dart' as timeago;

class postfunctions with ChangeNotifier {
  TextEditingController commentContrller = TextEditingController();
  ConstantColors constantColors = ConstantColors();

  String imageTimePosted;
  String get getImageTimePosted => imageTimePosted;

  showTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    imageTimePosted = timeago.format(dateTime);
    print(imageTimePosted);
    notifyListeners();
  }

  Future addlike(BuildContext context, String postId, String subDocId) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(subDocId)
        .set({
      'likes': FieldValue.increment(1),
      'username': Provider.of<firebaseopertrations>(context, listen: false)
          .getInitUserName,
      'useruid': Provider.of<authentication>(context, listen: false).getUserid,
      'userimage': Provider.of<firebaseopertrations>(context, listen: false)
          .getInitUserImage,
      'useremail': Provider.of<firebaseopertrations>(context, listen: false)
          .getInitUserEmail,
      'time': Timestamp.now()
    });
  }

  Future addcomment(BuildContext context, String postId, String comment) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(comment)
        .set({
      'comment': comment,
      'username': Provider.of<firebaseopertrations>(context, listen: false)
          .getInitUserName,
      'useruid': Provider.of<authentication>(context, listen: false).getUserid,
      'userimage': Provider.of<firebaseopertrations>(context, listen: false)
          .getInitUserImage,
      'useremail': Provider.of<firebaseopertrations>(context, listen: false)
          .getInitUserEmail,
      'time': Timestamp.now()
    });
  }

  showCommentsSheet(
      BuildContext context, DocumentSnapshot snapshot, String docId) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 100.0, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColors.blackColor,
                    ),
                  ),
                  Container(
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: constantColors.blackColor),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Text(
                        "Comments",
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(docId)
                          .collection('comments')
                          .orderBy('time')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot documentSnapshot) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 8.0),
                                            child: GestureDetector(
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    constantColors.darkColor,
                                                radius: 15.0,
                                                backgroundImage: NetworkImage(
                                                    documentSnapshot[
                                                        'userimage']),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                              child: Text(
                                                documentSnapshot['username'],
                                                style: TextStyle(
                                                  color:
                                                      constantColors.blackColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      FontAwesomeIcons.arrowUp,
                                                      color: constantColors
                                                          .blackColor,
                                                      size: 12.0,
                                                    )),
                                                Text(
                                                  '0',
                                                  style: TextStyle(
                                                      color: constantColors
                                                          .blackColor,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      FontAwesomeIcons.reply,
                                                      color: constantColors
                                                          .blackColor,
                                                      size: 12.0,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color:
                                                      constantColors.blackColor,
                                                  size: 12.0,
                                                )),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              child: Text(
                                                documentSnapshot['comment'],
                                                style: TextStyle(
                                                    color: constantColors
                                                        .blackColor,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  FontAwesomeIcons.trash,
                                                  color:
                                                      constantColors.blackColor,
                                                  size: 16.0,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: constantColors.darkColor
                                            .withOpacity(0.2),
                                      ),
                                    ]),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 300.0,
                          height: 50.0,
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                hintText: 'Add Comment...',
                                hintStyle: TextStyle(
                                    color: constantColors.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            controller: commentContrller,
                            style: TextStyle(
                                color: constantColors.blackColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            print("Adding comment");
                            addcomment(context, snapshot['caption'],
                                    commentContrller.text)
                                .whenComplete(() {
                              commentContrller.clear();
                              notifyListeners();
                            });
                          },
                          backgroundColor: constantColors.blackColor,
                          child: Icon(FontAwesomeIcons.comment,
                              color: constantColors.whiteColor),
                        )
                      ],
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: constantColors.yellowColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
            ),
          );
        });
  }

  showlikes(BuildContext context, String postId) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.blackColor,
                  ),
                ),
                Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: constantColors.blackColor),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      "Likes",
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .collection('likes')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot documentSnapshot) {
                            return ListTile(
                              leading: GestureDetector(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    documentSnapshot['userimage'],
                                  ),
                                ),
                              ),
                              title: Text(
                                documentSnapshot['username'],
                                style: TextStyle(
                                    color: constantColors.blackColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                documentSnapshot['useremail'],
                                style: TextStyle(
                                    color: constantColors.blackColor,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Provider.of<authentication>(context,
                                              listen: false)
                                          .getUserid ==
                                      documentSnapshot['useruid']
                                  ? Container(
                                      width: 0.0,
                                      height: 0.0,
                                    )
                                  : MaterialButton(
                                      child: Text("Follow",
                                          style: TextStyle(
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0)),
                                      onPressed: () {},
                                      color: constantColors.blueColor,
                                    ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.yellowColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
          );
        });
  }
}