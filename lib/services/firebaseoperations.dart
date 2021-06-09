import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/screens/landingpage/landingutils.dart';

class firebaseopertrations with ChangeNotifier {
  UploadTask imageuploadTask;

  Future uploaduserAvatar(BuildContext context) async {
    Reference imageRefrence = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<landingutls>(context, listen: false).getuserAvatar.path}${TimeOfDay.now()}');

    imageuploadTask = imageRefrence.putFile(
        Provider.of<landingutls>(context, listen: false).getuserAvatar);

    await imageuploadTask.whenComplete(() {
      print('Image uploaded');
    });

    imageRefrence.getDownloadURL().then((url) {
      Provider.of<landingutls>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          'the provile user avatar url => $Provider.of<landingutls>(context,listen: false).userAvatarUrl');
      notifyListeners();
    });
  }
}
