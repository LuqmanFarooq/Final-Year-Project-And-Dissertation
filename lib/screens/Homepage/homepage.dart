import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Chatroom/chatroom.dart';
import 'package:the_social/screens/Timeline/feed.dart';
import 'package:the_social/screens/Homepage/homepagehelpers.dart';
import 'package:the_social/screens/Profile/profile.dart';
import 'package:the_social/screens/Profile/profilehelpers.dart';
import 'package:the_social/Backend/firebaseoperations.dart';

//this is homepage class responsible for navigation between app screens
//we have used page controller as we have bottom navigation it helps to switch the tab.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  //initally page index is 0 and it will everythime land on homepage
  int pageIndex = 0;

  //init states helpes to initalzie app data from firebase as we have called firebase userdata in init state.
  //later using that init data in the homescreen to get the data ahead..
  @override
  void initState() {
    Provider.of<FirebaseOpertrations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // handling the back button action
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
          //here is the pageview to help as go through the pages..
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
          //passing the page reference to the bottom navigation so when we click on any icon then it naviagtes to the page associated with it.
          bottomNavigationBar:
              Provider.of<HomePageHelpers>(context, listen: false)
                  .bottomNavBar(context, pageIndex, homepageController)),
    );
  }
}
