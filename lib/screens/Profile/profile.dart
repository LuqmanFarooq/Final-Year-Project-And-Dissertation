import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Profile/profilehelpers.dart';
import 'package:the_social/screens/landingpage/landingpage.dart';
import 'package:the_social/services/authentication.dart';

class profile extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                EvaIcons.settings2Outline,
                color: constantColors.whiteColor,
              ),
              onPressed: () {}),
          actions: [
            IconButton(
                icon: Icon(
                  EvaIcons.logInOutline,
                  color: constantColors.whiteColor,
                ),
                onPressed: () {
                  Provider.of<profilehelpers>(context, listen: false)
                      .logutdialog(context);
                })
          ],
          backgroundColor: constantColors.blackColor,
          title: RichText(
              text: TextSpan(
                  text: "Your ",
                  style: TextStyle(
                    color: constantColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Profile',
                  style: TextStyle(
                    color: constantColors.yellowColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                )
              ])),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(Provider.of<Authentication>(context).getUserid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: [
                        Provider.of<profilehelpers>(context, listen: false)
                            .headerprofile(context, snapshot),
                        Provider.of<profilehelpers>(context, listen: false)
                            .divider(),
                        Provider.of<profilehelpers>(context, listen: false)
                            .middleProfile(context, snapshot),
                        Provider.of<profilehelpers>(context, listen: false)
                            .footerProfile(context, snapshot),
                      ],
                    );
                  }
                }),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: constantColors.yellowColor,
            ),
          ),
        )));
  }
}
