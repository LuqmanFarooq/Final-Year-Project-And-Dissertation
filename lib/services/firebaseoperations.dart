import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/screens/landingpage/landingutils.dart';
import 'package:the_social/services/authentication.dart';

class firebaseopertrations with ChangeNotifier {
  UploadTask imageuploadTask;

  String initUserEmail, initUserName, initUserImage;
  String get getInitUserName => initUserName;
  String get getInitUserEmail => initUserEmail;
  String get getInitUserImage => initUserImage;

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

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<authentication>(context, listen: false).getUserid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<authentication>(context, listen: false).getUserid)
        .get()
        .then((doc) {
      print("Fetching user data");
      initUserEmail = doc.data()['username'];
      initUserName = doc.data()['useremail'];
      initUserImage = doc.data()['userimage'];
      print(initUserName);
      print(initUserEmail);
      print(initUserImage);
      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }
}
