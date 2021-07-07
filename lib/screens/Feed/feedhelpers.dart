import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/utils/postfunctions.dart';
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
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
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
                color: constantColors.darkColor.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0)))),
      ),
    );
  }

  Widget loadposts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
        children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.63,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Row(
                children: [
                  GestureDetector(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(documentSnapshot['caption'],
                                  style: TextStyle(
                                      color: constantColors.greenColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0))),
                          Container(
                              child: RichText(
                            text: TextSpan(
                                text: documentSnapshot['username'],
                                style: TextStyle(
                                    color: constantColors.greenColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' , 12 hours ago',
                                      style: TextStyle(
                                          color: constantColors.lightColor
                                              .withOpacity(0.8)))
                                ]),
                          ))
                        ],
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
              padding: const EdgeInsets.only(top: 8.0, left: 20.0),
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
                            Provider.of<postfunctions>(context, listen: false)
                                .showlikes(
                                    context, documentSnapshot['caption']);
                          },
                          onTap: () {
                            Provider.of<postfunctions>(context, listen: false)
                                .addlike(
                                    context,
                                    documentSnapshot['caption'],
                                    Provider.of<authentication>(context,
                                            listen: false)
                                        .getUserid);
                          },
                          child: Icon(
                            FontAwesomeIcons.heart,
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
                                          color: constantColors.whiteColor,
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
                            Provider.of<postfunctions>(context, listen: false)
                                .showCommentsSheet(context, documentSnapshot,
                                    documentSnapshot['caption']);
                          },
                          child: Icon(
                            FontAwesomeIcons.comment,
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
                                          color: constantColors.whiteColor,
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
                          child: Icon(
                            FontAwesomeIcons.award,
                            color: constantColors.yellowColor,
                            size: 22.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('0',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Provider.of<authentication>(context, listen: false)
                              .getUserid ==
                          documentSnapshot['useruid']
                      ? IconButton(
                          icon: Icon(
                            EvaIcons.moreVertical,
                            color: constantColors.whiteColor,
                          ),
                          onPressed: () {})
                      : Container(
                          width: 0,
                          height: 0,
                        )
                ],
              ),
            ),
          ],
        ),
      );
    }).toList());
  }
}
