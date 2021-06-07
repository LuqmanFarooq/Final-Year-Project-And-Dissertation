import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/landingpage/landinghelpers.dart';
import 'package:the_social/screens/splashscreen/splashscreen.dart';
import 'package:the_social/services/authentication.dart';

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
          ChangeNotifierProvider(create: (_) => authentication()),
          ChangeNotifierProvider(create: (_) => landinghelpers())
        ]);
  }
}
