import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/userprofile/userprofilehelper.dart';

class userProfile extends StatelessWidget {
  final String userUid;
  userProfile({@required this.userUid});
  final ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Provider.of<userprofilehelper>(context, listen: false)
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
                        Provider.of<userprofilehelper>(context, listen: false)
                            .headerprofile(context, snapshot, userUid),
                        Provider.of<userprofilehelper>(context, listen: false)
                            .divider(),
                        Provider.of<userprofilehelper>(context, listen: false)
                            .middleProfile(context, snapshot),
                        Provider.of<userprofilehelper>(context, listen: false)
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
