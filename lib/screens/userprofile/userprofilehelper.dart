import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Homepage/homepage.dart';
import 'package:the_social/screens/userprofile/userprofile.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebaseoperations.dart';
import 'package:the_social/utils/postfunctions.dart';

class UserProfileHelper with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: constantColors.whiteColor,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: HomePage(), type: PageTransitionType.bottomToTop));
          }),
      actions: [
        IconButton(
            icon: Icon(
              Icons.more_vert_outlined,
              color: constantColors.whiteColor,
            ),
            onPressed: () {})
      ],
      backgroundColor: constantColors.blackColor,
      title: RichText(
          text: TextSpan(
              text: "City ",
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
    );
  }

  Widget headerprofile(BuildContext context,
      AsyncSnapshot<DocumentSnapshot> snapshot, String userUid) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.49,
      width: MediaQuery.of(context).size.width,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 200.0,
            width: 190.0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: CircleAvatar(
                      backgroundColor: constantColors.transperant,
                      radius: 55.0,
                      backgroundImage: NetworkImage(snapshot
                              .data['userimage'] ??
                          "https://www.solidbackgrounds.com/images/950x350/950x350-white-solid-color-background.jpg"),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(snapshot.data['username'],
                        style: TextStyle(
                            color: constantColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0))),
                Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          EvaIcons.email,
                          color: constantColors.blackColor,
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(snapshot.data['useremail'],
                              style: TextStyle(
                                  color: constantColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        checkFollowersSheet(context, snapshot);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: constantColors.darkColor,
                            borderRadius: BorderRadius.circular(15.0)),
                        height: 70.0,
                        width: 80.0,
                        child: Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(snapshot.data['useruid'])
                                    .collection('followers')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Text(
                                        snapshot.data.docs.length.toString(),
                                        style: TextStyle(
                                            color: constantColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28.0));
                                  }
                                }),
                            Text('Followers',
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: constantColors.darkColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      height: 70.0,
                      width: 80.0,
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(snapshot.data['useruid'])
                                  .collection('following')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Text(
                                      snapshot.data.docs.length.toString(),
                                      style: TextStyle(
                                          color: constantColors.whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28.0));
                                }
                              }),
                          Text('Following',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: constantColors.darkColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      height: 70.0,
                      width: 80.0,
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(snapshot.data['useruid'])
                                  .collection('posts')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Text(
                                      snapshot.data.docs.length.toString(),
                                      style: TextStyle(
                                          color: constantColors.whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28.0));
                                }
                              }),
                          Text('Posts',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              //color: constantColors.blackColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Provider.of<FirebaseOpertrations>(context, listen: false)
                          .followUser(
                              userUid,
                              Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserid,
                              {
                                'username': Provider.of<FirebaseOpertrations>(
                                        context,
                                        listen: false)
                                    .getInitUserName,
                                'userimage': Provider.of<FirebaseOpertrations>(
                                        context,
                                        listen: false)
                                    .getInitUserImage,
                                'useruid': Provider.of<Authentication>(context,
                                        listen: false)
                                    .getUserid,
                                'useremail': Provider.of<FirebaseOpertrations>(
                                        context,
                                        listen: false)
                                    .getInitUserEmail,
                                'time': Timestamp.now()
                              },
                              Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserid,
                              userUid,
                              {
                                'username': snapshot.data['username'],
                                'userimage': snapshot.data['userimage'],
                                'useremail': snapshot.data['useremail'],
                                'useruid': snapshot.data['useruid'],
                                'time': Timestamp.now(),
                              })
                          .whenComplete(() {
                        followedNotification(
                            context, snapshot.data['username']);
                      });
                    },
                    color: Colors.black,
                    child: Text(
                      "Follow",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.black,
                    child: Text(
                      "Message",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return Center(
      child: SizedBox(
        height: 25.0,
        width: 350.0,
        child: Divider(color: constantColors.blackColor),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  FontAwesomeIcons.angleDoubleDown,
                  color: constantColors.blackColor,
                  size: 16.0,
                ),
                Text(
                  "Recently Added",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: constantColors.blackColor),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: constantColors.darkColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15.0)
                    //child: ,
                    ),
              )),
        ],
      ),
    );
  }

  Widget footerProfile(BuildContext context, dynamic snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data['useruid'])
                  .collection('posts')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView(
                      children: snapshot.data.docs
                          .map((DocumentSnapshot documentSnapshot) {
                        return GestureDetector(
                          onTap: () {
                            showpostDetails(context, documentSnapshot);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                child: FittedBox(
                                  child: Image.network(
                                      documentSnapshot['postimage']),
                                )),
                          ),
                        );
                      }).toList(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2));
                }
              }),
          height: MediaQuery.of(context).size.height * 0.28,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: constantColors.darkColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(5.0))),
    );
  }

  followedNotification(BuildContext context, String name) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.blackColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("You just Followed $name",
                      style: TextStyle(
                          color: constantColors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.yellowColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }

  checkFollowersSheet(BuildContext context, dynamic snapshot) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(snapshot.data['useruid'])
                    .collection('followers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: snapshot.data.docs
                            .map((DocumentSnapshot documentSnapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ListTile(
                              onTap: () {
                                if (documentSnapshot['useruid'] !=
                                    Provider.of<Authentication>(context,
                                            listen: false)
                                        .getUserid) {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: UserProfile(
                                              userUid:
                                                  documentSnapshot['useruid']),
                                          type:
                                              PageTransitionType.bottomToTop));
                                }
                              },
                              trailing: documentSnapshot['useruid'] ==
                                      Provider.of<Authentication>(context,
                                              listen: false)
                                          .getUserid
                                  ? Container(
                                      width: 0.0,
                                      height: 0.0,
                                    )
                                  : MaterialButton(
                                      onPressed: () {},
                                      color: constantColors.blackColor,
                                      child: Text('Unfollow',
                                          style: TextStyle(
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0))),
                              leading: CircleAvatar(
                                backgroundColor: constantColors.transperant,
                                backgroundImage:
                                    NetworkImage(documentSnapshot['userimage']),
                              ),
                              title: Text(
                                documentSnapshot['username'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                documentSnapshot['useremail'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        }).toList(),
                      ),
                    );
                  }
                }),
          );
        });
  }

  showpostDetails(BuildContext context, DocumentSnapshot documentSnapshot) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      child: Image.network(documentSnapshot['postimage']),
                    )),
                Text(
                  documentSnapshot['caption'],
                  style: TextStyle(
                      color: constantColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showlikes(
                                        context, documentSnapshot['caption']);
                              },
                              onTap: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .addlike(
                                        context,
                                        documentSnapshot['caption'],
                                        Provider.of<Authentication>(context,
                                                listen: false)
                                            .getUserid);
                              },
                              child: Icon(
                                FontAwesomeIcons.solidHeart,
                                color: constantColors.redColor,
                                size: 22.0,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(
                                      documentSnapshot['caption'],
                                    )
                                    .collection('likes')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          snapshot.data.docs.length.toString(),
                                          style: TextStyle(
                                              color: constantColors.blackColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                      Container(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showCommentsSheet(
                                        context,
                                        documentSnapshot,
                                        documentSnapshot['caption']);
                              },
                              child: Icon(
                                FontAwesomeIcons.solidComment,
                                color: constantColors.blueColor,
                                size: 22.0,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(
                                      documentSnapshot['caption'],
                                    )
                                    .collection('comments')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          snapshot.data.docs.length.toString(),
                                          style: TextStyle(
                                              color: constantColors.blackColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                      Spacer(),
                      Provider.of<Authentication>(context, listen: false)
                                  .getUserid ==
                              documentSnapshot['useruid']
                          ? IconButton(
                              icon: Icon(
                                EvaIcons.moreVertical,
                                color: constantColors.blackColor,
                              ),
                              onPressed: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showPostOptions(
                                        context, documentSnapshot['caption']);
                              })
                          : Container(
                              width: 0,
                              height: 0,
                            )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
