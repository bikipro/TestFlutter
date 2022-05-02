import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/home/body/chat_page/chat_page_home.dart';
import 'package:pay/home/body/friend_model.dart';

class FriendProfile extends StatefulWidget {
  final String uid;
  final FriendModel detail;

  const FriendProfile({Key? key, this.uid = "", required this.detail})
      : super(key: key);

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Details"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFFF7F3F0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Scaffold(
                                    body: Center(
                                        child: Image.network(
                                            widget.detail.profile)))));
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.detail.profile),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            widget.detail.name,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            widget.detail.email,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              fontSize: 12,
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPageHome(
                                              uid: widget.detail.id,
                                            )));
                              },
                              icon: const Icon(Icons.sms)),
                          const Text("Chat")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.phone)),
                          const Text("Phome")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.video_call)),
                          const Text("Video")
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text("Delete friend"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.block, color: Colors.red),
                title: Text("Block friend"),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getUsersDetailss(String id) async {
    FirebaseFirestore.instance.collection("Users").doc(id).get().then((value) {
      FriendModel model = FriendModel(value.data()!["name"],
          value.data()!["elail"], value.data()!["profile"]);
    });
  }
}
