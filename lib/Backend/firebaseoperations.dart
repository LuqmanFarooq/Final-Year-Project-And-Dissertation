import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/screens/WelcomePage/WelcomePageUtils.dart';
import 'package:the_social/Backend/authentication.dart';

class FirebaseOpertrations with ChangeNotifier {
  UploadTask imageuploadTask;

  String initUserName, initUserEmail, initUserImage;
  String get getInitUserName => initUserName;
  String get getInitUserEmail => initUserEmail;
  String get getInitUserImage => initUserImage;

  Future uploaduserAvatar(BuildContext context) async {
    Reference imageRefrence = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<WelcomeUtils>(context, listen: false).getuserAvatar.path}${TimeOfDay.now()}');

    imageuploadTask = imageRefrence.putFile(
        Provider.of<WelcomeUtils>(context, listen: false).getuserAvatar);

    await imageuploadTask.whenComplete(() {
      print('Image uploaded');
    });

    imageRefrence.getDownloadURL().then((url) {
      Provider.of<WelcomeUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          'the provile user avatar url => $Provider.of<landingutls>(context,listen: false).userAvatarUrl');
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserid)
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

  Future deleteUserData(String useruid, dynamic collection) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(useruid)
        .delete();
  }

  Future updateCaption(String postId, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(data);
  }

  Future followUser(
      String followingUid,
      String followingDocid,
      dynamic followingData,
      String followerUid,
      String followerDocid,
      dynamic followerData) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(followingUid)
        .collection('followers')
        .doc(followingDocid)
        .set(followingData)
        .whenComplete(() async {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(followerUid)
          .collection('following')
          .doc(followerDocid)
          .set(followerData);
    });
  }

  Future unFollowUser(String followingUid, String followingDocid) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(followingUid)
        .collection('followers')
        .doc(followingDocid)
        .delete();
  }

  Future submitChatroomData(String chatroomName, dynamic chatroomData) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomName)
        .set(chatroomData);
  }
}
