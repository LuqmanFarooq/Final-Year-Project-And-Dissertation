import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Chatroom/chatroomhelpers.dart';
import 'package:the_social/screens/Feed/feedhelpers.dart';
import 'package:the_social/screens/Homepage/homepagehelpers.dart';
import 'package:the_social/screens/Messaging/groupmessageshelper.dart';
import 'package:the_social/screens/Profile/profilehelpers.dart';
import 'package:the_social/screens/WelcomePage/WelcomePageHelpers.dart';
import 'package:the_social/screens/WelcomePage/WelcomePageServices.dart';
import 'package:the_social/screens/WelcomePage/WelcomePageUtils.dart';
import 'package:the_social/screens/Splashscreen/Splashscreen.dart';
import 'package:the_social/screens/userprofile/userprofilehelper.dart';
import 'package:the_social/Backend/authentication.dart';
import 'package:the_social/Backend/firebaseoperations.dart';
import 'package:the_social/Post/postfunctions.dart';
import 'package:the_social/Post/uploadpost.dart';

//this is the main screen
//This function tells Dart where the program starts
//it must be in the file that is considered the "entry point" for you program
void main() async {
  //WidgetsBinding ensureInitialized() Returns an instance of the WidgetsBinding, creating and initializing it if necessary.
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp() creates and initializes a Firebase app instance
  await Firebase.initializeApp();
  //The runApp() function should return widget that would be attached to the screen as a root of the widget here in our case its myApp()
  runApp(MyApp());
}

//there are two type of widgets in flutter statefull and stateless
//here we have used stateless because we dont want the setstate function here.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    //here mostly we return MAterial App but we have a Materil App as a child of this widget.
    //Because we have used statemanagement tool Provider and to have acess to its functionality it is procedure to follow.
    return MultiProvider(
        child: MaterialApp(
          //this is added it means that we are going to remove the debug banner from top.
          debugShowCheckedModeBanner: false,
          //here we can set the theme and use in the whole app by reffernce
          theme: ThemeData(
              accentColor: constantColors.blueColor,
              fontFamily: 'Poppins',
              canvasColor: Colors.transparent),
          //a material Aapp always return a home where our app starts in our condition we started it from splash screen.
          home: Splashscreen(),
        ),
        providers: [
          //here I have listed all the providers we have used in out project it is nessary to mention them
          //here otherwise we cant render the set state
          //further change notifiacation method enables us to render and use the updated state in the change notifier class where it is extended.
          ChangeNotifierProvider(create: (_) => GroupMessagingHelper()),
          ChangeNotifierProvider(create: (_) => ChatRoomHelpers()),
          ChangeNotifierProvider(create: (_) => UserProfileHelper()),
          ChangeNotifierProvider(create: (_) => PostFunctions()),
          ChangeNotifierProvider(create: (_) => FeedHelpers()),
          ChangeNotifierProvider(create: (_) => uploadpost()),
          ChangeNotifierProvider(create: (_) => ProfileHelpers()),
          ChangeNotifierProvider(create: (_) => HomePageHelpers()),
          ChangeNotifierProvider(create: (_) => WelcomeUtils()),
          ChangeNotifierProvider(create: (_) => FirebaseOpertrations()),
          ChangeNotifierProvider(create: (_) => WelcomeService()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => WelcomePageHelpers())
        ]);
  }
}
