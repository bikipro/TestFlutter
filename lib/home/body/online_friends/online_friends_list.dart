import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay/home/body/online_friends/online_friends_recorde_layout.dart';

class OnlineFriendsList extends StatefulWidget {
  final String myId;
  const OnlineFriendsList({Key? key, required this.myId}) : super(key: key);

  @override
  State<OnlineFriendsList> createState() => _OnlineFriendsListState();
}

class _OnlineFriendsListState extends State<OnlineFriendsList> {
  bool online = true;

  @override
  Widget build(BuildContext context) {
    return online
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Friend")
                .doc(widget.myId)
                .collection("friends")
                .where('status', isEqualTo: "friend")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                online = false;
                return const Center(
                  child: SizedBox(
                    height: 1,
                  ),
                );
              } else {
                List id = [];

                snapshot.data!.docs.forEach((element) {
                  id.add(element.id);
                });

                //List<DocumentSnapshot> docs = snapshot.data!.docs;
                if (id.isEmpty) {
                  return const SizedBox(
                    height: 1,
                  );
                } else {
                  return OnlineFriendsRecordeLayout(id: id, myId: widget.myId);
                }
              }
            })
        : SizedBox(
            height: 1,
          );
  }
}
