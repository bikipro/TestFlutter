import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/home/body/friend_model.dart';

import 'friesd_request_recorde.dart';

class RequestedFriend extends StatefulWidget {
  final String myId;
  const RequestedFriend({
    Key? key,
    required this.myId,
  }) : super(key: key);

  @override
  State<RequestedFriend> createState() => _RequestedFriendState();
}

class _RequestedFriendState extends State<RequestedFriend> {
  FriendModel myModel = FriendModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.myId)
        .get()
        .then((value) {
      myModel.name = value.data()!['name'];
      myModel.email = value.data()!['email'];
      myModel.profile = value.data()!['profile'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white, //Color(0xFFF7F3F0),
          title: Text(
            "Friend Request",
            style: GoogleFonts.baloo(textStyle: const TextStyle()),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xFFF7F3F0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Friend")
                .doc(widget.myId)
                .collection("friends")
                .where("status", isEqualTo: "get")
                .snapshots(),
            //initialData: initialData,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot recordeSnapshot) {
                    Map<String, dynamic> data =
                        recordeSnapshot.data()! as Map<String, dynamic>;
                    FriendModel friendModel = FriendModel(
                        "",
                        data['name'].toString(),
                        data['email'].toString(),
                        data['profile'].toString());
                    return FriendrequestRecorde(
                        myModel: myModel,
                        uid: recordeSnapshot.id,
                        friendModel: friendModel);
                  }).toList(),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(
                child: Text("no friend request"),
              );
            },
          ),
        ));
  }
}
