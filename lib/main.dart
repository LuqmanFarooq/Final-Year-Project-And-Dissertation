import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Chatroom/chatroomhelpers.dart';
import 'package:the_social/screens/Feed/feedhelpers.dart';
import 'package:the_social/screens/Homepage/homepagehelpers.dart';
import 'package:the_social/screens/Profile/profilehelpers.dart';
import 'package:the_social/screens/landingpage/landinghelpers.dart';
import 'package:the_social/screens/landingpage/landingservices.dart';
import 'package:the_social/screens/landingpage/landingutils.dart';
import 'package:the_social/screens/splashscreen/splashscreen.dart';
import 'package:the_social/screens/userprofile/userprofilehelper.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebaseoperations.dart';
import 'package:the_social/utils/postfunctions.dart';
import 'package:the_social/utils/uploadpost.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              accentColor: constantColors.blueColor,
              fontFamily: 'Poppins',
              canvasColor: Colors.transparent),
          home: splashscreen(),
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => chatroomhelpers()),
          ChangeNotifierProvider(create: (_) => userprofilehelper()),
          ChangeNotifierProvider(create: (_) => postfunctions()),
          ChangeNotifierProvider(create: (_) => feedhelpers()),
          ChangeNotifierProvider(create: (_) => uploadpost()),
          ChangeNotifierProvider(create: (_) => profilehelpers()),
          ChangeNotifierProvider(create: (_) => homepagehelpers()),
          ChangeNotifierProvider(create: (_) => landingutls()),
          ChangeNotifierProvider(create: (_) => firebaseopertrations()),
          ChangeNotifierProvider(create: (_) => landingservice()),
          ChangeNotifierProvider(create: (_) => authentication()),
          ChangeNotifierProvider(create: (_) => landinghelpers())
        ]);
  }
}
