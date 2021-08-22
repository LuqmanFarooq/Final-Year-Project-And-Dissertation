import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebaseoperations.dart';

class uploadpost with ChangeNotifier {
  //this class is extended from change notifier because this class has all the upload post methods
  // and all the changes that are going to be made after upload post the change notifier is going to notify it further.
  TextEditingController captionController = TextEditingController();
  ConstantColors constantColors = ConstantColors();
  File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String uploadpostImageURL;
  String get getUploadPostImageUrl => uploadpostImageURL;
  final picker = ImagePicker();
  UploadTask imagePostUploadTask;
  // the above methoned variables are the variable I have globalized  so that I can use in my app further.

  Future pickuserPostImage(
      BuildContext context, ImageSource imageSource) async {
    final uploadpostImageVal = await picker.getImage(source: imageSource);
    uploadpostImageVal == null
        ? print('Select Image')
        : uploadPostImage = File(uploadpostImageVal.path);
    print(uploadpostImageVal.path);

    uploadPostImage != null
        ? showPostImage(context)
        : print('Image upload error');
    notifyListeners();
  }

  Future uploadPostImageToFirebase() async {
    Reference imageReferance = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
    imagePostUploadTask = imageReferance.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() {
      print("Posting image to firebase storage");
    });
    imageReferance.getDownloadURL().then((imageUrl) {
      uploadpostImageURL = imageUrl;
      print(uploadpostImageURL);
    });
    notifyListeners();
  }

  selectpostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.yellowColor,
                borderRadius: BorderRadius.circular(11)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        pickuserPostImage(context, ImageSource.gallery);
                      },
                      color: constantColors.blackColor,
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        pickuserPostImage(context, ImageSource.camera);
                      },
                      color: constantColors.blackColor,
                      child: Text(
                        "Camera",
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.39,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.yellowColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.blackColor,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    height: 200.0,
                    width: 400.0,
                    child: Image.file(
                      uploadPostImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                          child: Text("Reselect",
                              style: TextStyle(
                                  color: constantColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: constantColors.blackColor)),
                          onPressed: () {
                            selectpostImageType(context);
                          }),
                      MaterialButton(
                          color: constantColors.blackColor,
                          child: Text("Confirm Image",
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            uploadPostImageToFirebase().whenComplete(() {
                              editPostSheet(context);
                              print("Image uploaded");
                            });
                          }),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  editPostSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.blackColor,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.image_aspect_ratio,
                                  color: constantColors.blackColor,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(
                                  Icons.fit_screen,
                                  color: constantColors.blackColor,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: Image.file(
                          uploadPostImage,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Icon(
                          Icons.comment,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 110.0,
                        width: 5.0,
                        color: constantColors.blackColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 120.0,
                          width: 330.0,
                          child: TextField(
                            maxLines: 5,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 100,
                            controller: captionController,
                            style: TextStyle(
                                color: constantColors.blackColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Add a caption..",
                              hintStyle: TextStyle(
                                  color: constantColors.blackColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  child: Text(
                    "Share",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  onPressed: () {
                    Provider.of<firebaseopertrations>(context, listen: false)
                        .uploadPostData(captionController.text, {
                      'caption': captionController.text,
                      'postimage': getUploadPostImageUrl,
                      'username': Provider.of<firebaseopertrations>(context,
                              listen: false)
                          .getInitUserName,
                      'userimage': Provider.of<firebaseopertrations>(context,
                              listen: false)
                          .getInitUserImage,
                      'useruid':
                          Provider.of<authentication>(context, listen: false)
                              .getUserid,
                      'time': Timestamp.now(),
                      'useremail': Provider.of<firebaseopertrations>(context,
                              listen: false)
                          .getInitUserEmail,
                    }).whenComplete(() {
                      // this will help us to add data to user profile means the post that user is going to upload
                      //we are going to upload it from here.
                      return FirebaseFirestore.instance
                          .collection('users')
                          .doc(Provider.of<authentication>(context,
                                  listen: false)
                              .getUserid)
                          .collection('posts')
                          .add({
                        'caption': captionController.text,
                        'postimage': getUploadPostImageUrl,
                        'username': Provider.of<firebaseopertrations>(context,
                                listen: false)
                            .getInitUserName,
                        'userimage': Provider.of<firebaseopertrations>(context,
                                listen: false)
                            .getInitUserImage,
                        'useruid':
                            Provider.of<authentication>(context, listen: false)
                                .getUserid,
                        'time': Timestamp.now(),
                        'useremail': Provider.of<firebaseopertrations>(context,
                                listen: false)
                            .getInitUserEmail,
                      });
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                  color: constantColors.blackColor,
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.yellowColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }
}
