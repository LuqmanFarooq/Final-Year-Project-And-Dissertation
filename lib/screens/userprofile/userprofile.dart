import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/userprofile/userprofilehelper.dart';

//this is same as profile.dart
// its for other users profile display
class UserProfile extends StatelessWidget {
  final String userUid;
  UserProfile({@required this.userUid});
  final ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Provider.of<UserProfileHelper>(context, listen: false)
            .appBar(context),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userUid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: [
                        // getting profile counts, recently added and posts by calling the defined methods in userprofilehelpers through provider
                        Provider.of<UserProfileHelper>(context, listen: false)
                            .headerprofile(context, snapshot, userUid),
                        Provider.of<UserProfileHelper>(context, listen: false)
                            .divider(),
                        Provider.of<UserProfileHelper>(context, listen: false)
                            .middleProfile(context, snapshot),
                        Provider.of<UserProfileHelper>(context, listen: false)
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
