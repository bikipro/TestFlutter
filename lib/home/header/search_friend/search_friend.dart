import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/home/body/friend_model.dart';
import 'package:pay/home/header/friend_requeest/friend_request.dart';
import 'package:pay/home/header/search_friend/searched_data.dart';

class SearchFriend extends StatefulWidget {
  final String myId;
  const SearchFriend({Key? key, required this.myId}) : super(key: key);

  @override
  State<SearchFriend> createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  FriendModel myModel = FriendModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      myModel.name = value.data()!['name'];
      myModel.email = value.data()!['email'];
      myModel.profile = value.data()!['profile'];
      setState(() {});
    });
  }

  Stream streamBuild =
      FirebaseFirestore.instance.collection("Users").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 30,
          leading: Material(
            color: Colors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Navigator.pop(context);
              },
              splashColor: Colors.orange,
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.keyboard_return,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 13,
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text("Search"),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        streamBuild = FirebaseFirestore.instance
                            .collection("Users")
                            .where('name', isGreaterThanOrEqualTo: value)
                            .where('name', isLessThan: value + 'z')
                            .snapshots();
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.2,
                  color: Colors.white,
                  child: StreamBuilder(
                      stream: streamBuild != null ? streamBuild : search("b"),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return ListView(
                            //padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              FriendModel friendModel = FriendModel(
                                  "",
                                  data['name'].toString(),
                                  data['email'].toString(),
                                  data['profile'].toString());
                              print("nnnn");
                              return SearchedData(
                                myDetail: myModel,
                                friendModel: friendModel,
                                uid: document.id,
                                myId: widget.myId,
                              );
                            }).toList(),
                          );
                        }
                        return const Center(
                          child: Text("no users"),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }

  search(String value) async {}
}
