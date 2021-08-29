import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Chatroom/chatroom.dart';
import 'package:the_social/screens/Feed/feed.dart';
import 'package:the_social/screens/Homepage/homepagehelpers.dart';
import 'package:the_social/screens/Profile/profile.dart';
import 'package:the_social/screens/Profile/profilehelpers.dart';
import 'package:the_social/Backend/firebaseoperations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<FirebaseOpertrations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      if (homepageController.page.round() == homepageController.initialPage) {
        return Provider.of<ProfileHelpers>(context, listen: false)
            .logutdialog(context);
      } else
        return homepageController.previousPage(
            duration: Duration(milliseconds: 300), curve: Curves.bounceOut);
    }

    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: Scaffold(
          backgroundColor: constantColors.darkColor,
          body: PageView(
            controller: homepageController,
            children: [Feed(), ChatRoom(), Profile()],
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                pageIndex = page;
              });
            },
          ),
          bottomNavigationBar:
              Provider.of<HomePageHelpers>(context, listen: false)
                  .bottomNavBar(context, pageIndex, homepageController)),
    );
  }
}
