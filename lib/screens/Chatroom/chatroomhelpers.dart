import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';

class chatroomhelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  final TextEditingController chatnameController = TextEditingController();
  showCreateChatroomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    color: constantColors.blackColor,
                    thickness: 4.0,
                  ),
                ),
                Text(
                  'Select Chatroom Avatar',
                  style: TextStyle(
                      color: constantColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chatroomIcons')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data.docs
                              .map((DocumentSnapshot documentSnapshot) {
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Container(
                                    height: 10.0,
                                    width: 40.0,
                                    child: Image.network(
                                      documentSnapshot['image'],
                                    )),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 200,
                      child: TextField(
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            hintText: 'Enter Chatroom ID',
                            hintStyle: TextStyle(
                                color: constantColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                        controller: chatnameController,
                        style: TextStyle(
                            color: constantColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: constantColors.blackColor,
                      child: Icon(
                        FontAwesomeIcons.plus,
                        size: 25,
                        color: constantColors.yellowColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.yellowColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
          );
        });
  }
}
