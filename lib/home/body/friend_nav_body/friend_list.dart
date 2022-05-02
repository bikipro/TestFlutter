import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/home/body/chat_page/chat_page_home.dart';
import 'package:pay/home/body/friend_model.dart';
import 'package:pay/home/body/friend_nav_body/friend_profile.dart';

class FriendList extends StatefulWidget {
  final String myId;
  const FriendList({Key? key, required this.myId}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Friend")
            .doc(widget.myId)
            .collection("friends")
            .where('status', isEqualTo: "friend")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Expanded(
              child: Center(
                  child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/img/no_friends_b.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              )),
            );
          } else {
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: const Color(0xFFF7F3F0),
                    child: InkWell(
                      child: ListTile(
                        minLeadingWidth: 60,
                        leading: SizedBox(
                            height: 60,
                            width: 60,
                            child: docs[index]['profile'] != ""
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(docs[index]['profile']))
                                : CircleAvatar(
                                    child: Text(docs[index]['name'][0]
                                        .toString()
                                        .toUpperCase()),
                                    backgroundColor: Colors.white,
                                  )),
                        title: Text(
                          docs[index]['name'],
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        subtitle: Text(docs[index]['email']),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FriendProfile(
                                        detail: FriendModel(
                                            docs[index].id,
                                            docs[index]['name'],
                                            docs[index]['email'],
                                            docs[index]['profile']),
                                      )));
                        },
                      ),
                    ),
                  );
                });
          }
        });
  }
}
