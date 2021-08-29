import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/userprofile/userprofile.dart';
import 'package:the_social/Backend/authentication.dart';
import 'package:the_social/Post/postfunctions.dart';
import 'package:the_social/Post/uploadpost.dart';

class FeedHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: constantColors.darkColor,
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.camera_enhance_rounded,
              color: constantColors.whiteColor,
            ),
            onPressed: () {
              Provider.of<uploadpost>(context, listen: false)
                  .selectpostImageType(context);
            })
      ],
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
              text: 'Feed',
              style: TextStyle(
                color: constantColors.yellowColor,
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
        padding: const EdgeInsets.only(top: 8.0, bottom: 50),
        child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                        height: 500.0,
                        width: 400.0,
                        child: Lottie.asset('assets/animations/loading.json')),
                  );
                } else {
                  return loadposts(context, snapshot);
                }
              },
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.greyColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0)))),
      ),
    );
  }

  Widget loadposts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150.0),
      child: ListView(
          children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
        Provider.of<PostFunctions>(context, listen: false)
            .showTimeAgo(documentSnapshot['time']);
        return Container(
          decoration: BoxDecoration(
              color: constantColors.yellowColor.withOpacity(0.8),
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          height: MediaQuery.of(context).size.height * 0.63,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (documentSnapshot['useruid'] !=
                              Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserid) {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: UserProfile(
                                      userUid: documentSnapshot['useruid'],
                                    ),
                                    type: PageTransitionType.bottomToTop));
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: constantColors.blueGreyColor,
                          radius: 20.0,
                          backgroundImage:
                              NetworkImage(documentSnapshot['userimage']),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 50.0,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(documentSnapshot['caption'],
                                        style: TextStyle(
                                            color: constantColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0))),
                                Container(
                                    child: RichText(
                                  text: TextSpan(
                                      text: documentSnapshot['useremail'],
                                      style: TextStyle(
                                          color: constantColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                ' , ${Provider.of<PostFunctions>(context, listen: false).getImageTimePosted.toString()}',
                                            style: TextStyle(
                                                color: constantColors.blackColor
                                                    .withOpacity(0.8)))
                                      ]),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   height: MediaQuery.of(context).size.height,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.46,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      child: Image.network(
                        documentSnapshot['postimage'],
                        scale: 2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
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
                ),
              ],
            ),
          ),
        );
      }).toList()),
    );
  }
}
