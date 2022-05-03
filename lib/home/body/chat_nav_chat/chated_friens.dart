import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/home/body/chat_page/chat_page_home.dart';

class ChatedFriend extends StatefulWidget {
  final String myId;
  const ChatedFriend({Key? key, required this.myId}) : super(key: key);

  @override
  State<ChatedFriend> createState() => _ChatedFriend();
}

class _ChatedFriend extends State<ChatedFriend> {
  bool chated = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Friend")
            .doc(widget.myId)
            .collection("friends")
            .where('chatId', isNotEqualTo: "")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            chated = false;
            //setState(() {});
            return SizedBox(width: 1);
          }
          if (snapshot.connectionState == ConnectionState.active) {
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
                                        NetworkImage(docs[index]['profile']),
                                  )
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
                        subtitle: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Chats")
                                .doc("Chats")
                                .collection(docs[index]["chatId"])
                                .orderBy('time', descending: true)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.data!.docs.first["type"] !=
                                    "img") {
                                  return snapshot.data!.docs.first["isSeen"]
                                      ? Text(snapshot.data!.docs.first["msg"])
                                      : Text(
                                          snapshot.data!.docs.first["msg"],
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        );
                                } else {
                                  return const Text("image");
                                }
                              }
                              return Text(" ");
                            }),
                        onTap: () async {
                          //  var snapshot = await FirebaseFirestore.instance
                          //     .collection("Users")
                          //     .doc(docs[index].id)
                          //     .get();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatPageHome(
                                        uid: docs[index].id,
                                        //token:snapshot.data()!['token']
                                      )));
                        },
                      ),
                    ),
                  );
                });
          }
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
        });
    //
  }
}
