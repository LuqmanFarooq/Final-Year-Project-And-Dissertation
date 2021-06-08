import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class landingutls with ChangeNotifier {
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

    userAvatar != null ?
  }
}
