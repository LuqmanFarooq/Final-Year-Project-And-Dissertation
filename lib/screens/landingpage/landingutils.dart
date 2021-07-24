import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/screens/landingpage/landingservices.dart';
import 'package:the_social/services/firebaseoperations.dart';

class landingutls with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  final picker = ImagePicker();
  File userAvatar;
  File get getuserAvatar => userAvatar;
  String userAvatarUrl;
  String get getuserAvatarUrl => userAvatarUrl;

  Future pickuserAvatar(BuildContext context, ImageSource imageSource) async {
    final pickeduserAvatar = await picker.getImage(source: imageSource);
    pickeduserAvatar == null
        ? print('Select Image')
        : userAvatar = File(pickeduserAvatar.path);
    print(userAvatar.path);

    userAvatar != null
        ? Provider.of<landingservice>(context, listen: false)
            .showUserAvatar(context)
        : print('Image upload error');
    notifyListeners();
  }

  Future selectAvatarOptionssheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.blackColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: constantColors.blackColor,
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          pickuserAvatar(context, ImageSource.gallery)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<landingservice>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        }),
                    MaterialButton(
                        color: constantColors.blackColor,
                        child: Text(
                          'Camera',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          pickuserAvatar(context, ImageSource.camera)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<landingservice>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        }),
                  ],
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.yellowColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }
}
