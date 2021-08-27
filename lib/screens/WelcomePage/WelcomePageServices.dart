import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Homepage/homepage.dart';
import 'package:the_social/screens/WelcomePage/WelcomePageUtils.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebaseoperations.dart';
import 'package:email_validator/email_validator.dart';

class WelcomeService with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.blackColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      radius: 60.0,
                      backgroundColor: constantColors.transperant,
                      backgroundImage: FileImage(
                          Provider.of<WelcomeUtils>(context, listen: false)
                              .userAvatar)),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                          child: Text("Reselect",
                              style: TextStyle(
                                  color: constantColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: constantColors.blackColor)),
                          onPressed: () {
                            Provider.of<WelcomeUtils>(context, listen: false)
                                .pickuserAvatar(context, ImageSource.gallery);
                          }),
                      MaterialButton(
                          color: constantColors.blackColor,
                          child: Text("Confirm Image",
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Provider.of<FirebaseOpertrations>(context,
                                    listen: false)
                                .uploaduserAvatar(context)
                                .whenComplete(() {
                              signupSheet(context);
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: constantColors.whiteColor,
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }

  Widget passwordLessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                    trailing: Container(
                      width: 120.0,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.check,
                              color: constantColors.blackColor,
                            ),
                            onPressed: () {
                              Provider.of<Authentication>(context,
                                      listen: false)
                                  .logIntoAccount(documentSnapshot['useremail'],
                                      documentSnapshot['userpassword'])
                                  .whenComplete(() {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: HomePage(),
                                        type: PageTransitionType.leftToRight));
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.trashAlt,
                              color: constantColors.redColor,
                            ),
                            onPressed: () {
                              Provider.of<FirebaseOpertrations>(context,
                                      listen: false)
                                  .deleteUserData(
                                      documentSnapshot['useruid'], "users");
                            },
                          ),
                        ],
                      ),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: constantColors.darkColor,
                        backgroundImage:
                            NetworkImage(documentSnapshot['userimage'])),
                    subtitle: Text(
                      documentSnapshot['useremail'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: constantColors.blackColor),
                    ),
                    title: Text(
                      documentSnapshot['username'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: constantColors.blackColor),
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
                        color: constantColors.blackColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: userEmailController,
                        decoration: InputDecoration(
                            hintText: 'Enter Email...',
                            hintStyle: TextStyle(
                                color: constantColors.blackColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                        style: TextStyle(
                            color: constantColors.blackColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        obscureText: true,
                        controller: userPasswordController,
                        decoration: InputDecoration(
                            hintText: 'Enter Password...',
                            hintStyle: TextStyle(
                                color: constantColors.blackColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                        style: TextStyle(
                            color: constantColors.blackColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FloatingActionButton(
                          backgroundColor: constantColors.blackColor,
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: constantColors.whiteColor,
                          ),
                          onPressed: () {
                            if (userEmailController.text.isNotEmpty) {
                              if (!EmailValidator.validate(
                                  userEmailController.text)) {
                                warningText(
                                    context, "Please enter a valid email");
                              } else
                                Provider.of<Authentication>(context,
                                        listen: false)
                                    .logIntoAccount(userEmailController.text,
                                        userPasswordController.text)
                                    .whenComplete(() {
                                  userEmailController.clear();
                                  userPasswordController.clear();
                                  // validation if the Credentials are correct
                                  if (Authentication.successLogin == true) {
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            child: HomePage(),
                                            type: PageTransitionType
                                                .bottomToTop));
                                  } //if
                                  else {
                                    warningText(context,
                                        "Incorrect Email or Password ! Try Again");
                                  }
                                });
                            } else {
                              warningText(context, "Fill all feilds !");
                            }
                          }),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: constantColors.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0))),
              ),
            ),
          );
        });
  }

  signupSheet(BuildContext context) {
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
                  color: constantColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColors.blackColor,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: FileImage(
                        Provider.of<WelcomeUtils>(context, listen: false)
                            .getuserAvatar),
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
                              color: constantColors.blackColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      style: TextStyle(
                          color: constantColors.blackColor,
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
                              color: constantColors.blackColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      style: TextStyle(
                          color: constantColors.blackColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      obscureText: true,
                      controller: userPasswordController,
                      decoration: InputDecoration(
                          hintText: 'Enter Password...',
                          hintStyle: TextStyle(
                              color: constantColors.blackColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                      style: TextStyle(
                          color: constantColors.blackColor,
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
                          if (userPasswordController.text.length < 6) {
                            warningText(context,
                                "Passwod cannot be less than 6 characters !");
                          } else if (userEmailController.text.isEmpty ||
                              userNameController.text.isEmpty) {
                            warningText(context, "Fill all feilds !");
                          } else if (!EmailValidator.validate(
                              userEmailController.text)) {
                            warningText(context, "Enter a valid Email");
                          } else if (userEmailController.text.isNotEmpty) {
                            Provider.of<Authentication>(context, listen: false)
                                .createAccount(userEmailController.text,
                                    userPasswordController.text)
                                .whenComplete(() async {
                              print("Creating collection");
                              await Provider.of<FirebaseOpertrations>(context,
                                      listen: false)
                                  .createUserCollection(context, {
                                'useruid': Provider.of<Authentication>(context,
                                        listen: false)
                                    .getUserid,
                                'useremail': userEmailController.text,
                                'userpassword': userPasswordController.text,
                                'username': userNameController.text,
                                'userimage': Provider.of<WelcomeUtils>(context,
                                        listen: false)
                                    .getuserAvatarUrl
                              });
                            }).whenComplete(() {
                              userPasswordController.clear();
                              userNameController.clear();
                              userEmailController.clear();
                              // if user successfully singsup
                              if (Authentication.successSignup == true) {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: HomePage(),
                                        type: PageTransitionType.bottomToTop));
                              } //if there is an error
                              else {
                                warningText(context,
                                    "SignUp Unsuccessful Check details again");
                              }
                            });
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
