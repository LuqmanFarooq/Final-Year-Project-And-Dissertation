import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/Backend/firebaseoperations.dart';

//we have used helper classes as we have used provider to manage the state of data
// This Class is responsible for custom navigation bar
class HomePageHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

  Widget bottomNavBar(
      BuildContext context, int index, PageController pageController) {
    //here is customnavigation bar or we say bottom navigation.
    return CustomNavigationBar(
      currentIndex: index,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.decelerate,
      selectedColor: constantColors.yellowColor,
      unSelectedColor: constantColors.whiteColor,
      strokeColor: constantColors.blueColor,
      scaleFactor: 0.5,
      iconSize: 30.0,
      onTap: (val) {
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
      },
      backgroundColor: Color(0xff040307),
      items: [
        //here are the three icons of bottom navigation home, message and profile respectively
        CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
        CustomNavigationBarItem(icon: Icon(Icons.message_rounded)),
        CustomNavigationBarItem(
            icon: CircleAvatar(
          radius: 35.0,
          backgroundColor: constantColors.blueGreyColor,
          backgroundImage: NetworkImage(Provider.of<FirebaseOpertrations>(
                      context,
                      listen: false)
                  .getInitUserImage ??
              "https://www.solidbackgrounds.com/images/950x350/950x350-white-solid-color-background.jpg"),
        )),
      ],
    );
  }
}
