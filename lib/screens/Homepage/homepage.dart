import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/Chatroom/chatroom.dart';
import 'package:the_social/screens/Feed/feed.dart';
import 'package:the_social/screens/Homepage/homepagehelpers.dart';
import 'package:the_social/screens/Profile/profile.dart';
import 'package:the_social/services/firebaseoperations.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<firebaseopertrations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColors.darkColor,
        body: PageView(
          controller: homepageController,
          children: [feed(), chatroom(), profile()],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
        ),
        bottomNavigationBar:
            Provider.of<homepagehelpers>(context, listen: false)
                .bottomNavBar(context, pageIndex, homepageController));
  }
}
