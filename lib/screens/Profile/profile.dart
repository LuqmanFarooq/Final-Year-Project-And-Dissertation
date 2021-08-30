import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Profile/profilehelpers.dart';
import 'package:the_social/Backend/authentication.dart';

//This is the class responsible for implementation of Profile page and its data
class Profile extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // heading on top
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
                // logutdialog method called through provider for logout functionality
                onPressed: () {
                  Provider.of<ProfileHelpers>(context, listen: false)
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
                        // getting profile counts, recently added and posts by calling the defined methods in profile helpers through provider
                        Provider.of<ProfileHelpers>(context, listen: false)
                            .headerprofile(context, snapshot),
                        Provider.of<ProfileHelpers>(context, listen: false)
                            .divider(),
                        Provider.of<ProfileHelpers>(context, listen: false)
                            .middleProfile(context, snapshot),
                        Provider.of<ProfileHelpers>(context, listen: false)
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
