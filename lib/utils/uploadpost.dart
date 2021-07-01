import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/services/authentication.dart';
import 'package:the_social/services/firebaseoperations.dart';

class uploadpost with ChangeNotifier {
  TextEditingController captionController = TextEditingController();
  ConstantColors constantColors = ConstantColors();
  File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String uploadpostImageURL;
  String get getUploadPostImageUrl => uploadpostImageURL;
  final picker = ImagePicker();
  UploadTask imagePostUploadTask;

  Future pickuserPostImage(
      BuildContext context, ImageSource imageSource) async {
    final uploadpostImageVal = await picker.getImage(source: imageSource);
    uploadpostImageVal == null
        ? print('Select Image')
        : uploadPostImage = File(uploadpostImageVal.path);
    print(uploadPostImage.path);

    uploadPostImage != null
        ? showPostImage(context)
        : print('Image upload error');
    notifyListeners();
  }

  Future uploadPostImageToFirebase() async {
    Reference imageReferance = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
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
                color: constantColors.blueGreyColor,
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
                      color: constantColors.blueColor,
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
                      color: constantColors.blueColor,
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
                color: constantColors.darkColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
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
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: constantColors.whiteColor)),
                          onPressed: () {
                            selectpostImageType(context);
                          }),
                      MaterialButton(
                          color: constantColors.blueColor,
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
                    color: constantColors.whiteColor,
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
                                  color: constantColors.greenColor,
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(
                                  Icons.fit_screen,
                                  color: constantColors.yellowColor,
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
                        child: Image.asset('assets/icons/sunflower.png'),
                      ),
                      Container(
                        height: 110.0,
                        width: 5.0,
                        color: constantColors.blueColor,
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
                                color: constantColors.whiteColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Add a caption..",
                              hintStyle: TextStyle(
                                  color: constantColors.whiteColor,
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
                      Navigator.pop(context);
                    });
                  },
                  color: constantColors.blueColor,
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }
}
