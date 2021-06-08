import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Homepage/homepage.dart';
import 'package:the_social/services/authentication.dart';

class landingservice with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  Widget passwordLessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('allUsers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                  return ListTile(
                    trailing: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.trashAlt,
                        color: constantColors.redColor,
                      ),
                      onPressed: () {},
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(documentSnapshot.get('userimaage')),
                    ),
                    subtitle: Text(
                      documentSnapshot.get('useremail'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: constantColors.greenColor),
                    ),
                    title: Text(
                      documentSnapshot.get('username'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: constantColors.greenColor),
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }

  loginSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 150.0),
                      child: Divider(
                        thickness: 4.0,
                        color: constantColors.whiteColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: userEmailController,
                        decoration: InputDecoration(
                            hintText: 'Enter Email...',
                            hintStyle: TextStyle(
                                color: constantColors.whiteColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: userPasswordController,
                        decoration: InputDecoration(
                            hintText: 'Enter Password...',
                            hintStyle: TextStyle(
                                color: constantColors.whiteColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FloatingActionButton(
                          backgroundColor: constantColors.blueColor,
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: constantColors.whiteColor,
                          ),
                          onPressed: () {
                            if (userEmailController.text.isNotEmpty) {
                              Provider.of<authentication>(context,
                                      listen: false)
                                  .logIntoAccount(userEmailController.text,
                                      userPasswordController.text)
                                  .whenComplete(() {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: homepage(),
                                        type: PageTransitionType.bottomToTop));
                              });
                            } else {
                              warningText(context, "Fill all feilds !");
                            }
                          }),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: constantColors.blueGreyColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0))),
              ),
            ),
          );
        });
  }

  signinSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: constantColors.blueGreyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: constantColors.redColor,
                    radius: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          hintText: 'Enter Name...',
                          hintStyle: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                          hintText: 'Enter Email...',
                          hintStyle: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                          hintText: 'Enter Password...',
                          hintStyle: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FloatingActionButton(
                        backgroundColor: constantColors.redColor,
                        child: Icon(
                          FontAwesomeIcons.check,
                          color: constantColors.whiteColor,
                        ),
                        onPressed: () {
                          if (userEmailController.text.isNotEmpty) {
                            Provider.of<authentication>(context, listen: false)
                                .createAccount(userEmailController.text,
                                    userPasswordController.text)
                                .whenComplete(() {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: homepage(),
                                      type: PageTransitionType.bottomToTop));
                            });
                          } else {
                            warningText(context, "Fill all feilds !");
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: constantColors.darkColor,
                  borderRadius: BorderRadius.circular(15.0)),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  warning,
                  style: TextStyle(
                      color: constantColors.whiteColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ));
        });
  }
}
