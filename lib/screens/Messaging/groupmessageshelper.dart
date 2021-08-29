import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/Backend/authentication.dart';
import 'package:the_social/Backend/firebaseoperations.dart';

class GroupMessagingHelper with ChangeNotifier {
  showmessages(BuildContext context, DocumentSnapshot documentSnapshot) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(documentSnapshot.id)
            .collection('messages')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              reverse: true,
              children:
                  snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.1,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.9),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        children: [
                                          Text(
                                            documentSnapshot['username'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '  ->  ' + documentSnapshot['message'],
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Provider.of<Authentication>(context,
                                                  listen: false)
                                              .getUserid ==
                                          documentSnapshot['useruid']
                                      ? Colors.amber.withOpacity(0.2)
                                      : Colors.amber,
                                  borderRadius: BorderRadius.circular(8)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
        });
  }

  sendMessage(BuildContext context, DocumentSnapshot documentSnapshot,
      TextEditingController messageControler) {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(documentSnapshot.id)
        .collection('messages')
        .add({
      'message': messageControler.text,
      'time': Timestamp.now(),
      'useruid': Provider.of<Authentication>(context, listen: false).getUserid,
      'username': Provider.of<FirebaseOpertrations>(context, listen: false)
          .getInitUserEmail,
      'userimage': Provider.of<FirebaseOpertrations>(context, listen: false)
          .getInitUserImage,
    }).whenComplete(() => messageControler.clear());
  }
}
