import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/home/body/friend_model.dart';

class FriendrequestRecorde extends StatefulWidget {
  final FriendModel friendModel;
  final String uid;
  final FriendModel myModel;
  const FriendrequestRecorde(
      {Key? key,
      required this.friendModel,
      required this.uid,
      required this.myModel})
      : super(
          key: key,
        );

  @override
  State<FriendrequestRecorde> createState() => _FriendrequestRecordeState();
}

class _FriendrequestRecordeState extends State<FriendrequestRecorde> {
  String myId = "";
  @override
  void initState() {
    super.initState();
    myId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                    height: 90,
                    width: 90,
                    child: widget.friendModel.profile != ""
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.friendModel.profile),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(widget.friendModel.name.toUpperCase()),
                          )),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.friendModel.name,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 20)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Do You want to Accept"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            CollectionReference reference =
                                                FirebaseFirestore.instance
                                                    .collection("Friend");
                                            reference
                                                .doc(myId)
                                                .collection("friends")
                                                .doc(widget.uid)
                                                .update({
                                              'status': "friend",
                                              'name': widget.friendModel.name,
                                              'email': widget.friendModel.name,
                                              'profile':
                                                  widget.friendModel.profile,
                                              'chatId': "",
                                            }).whenComplete(() {
                                              print(myId);
                                              reference
                                                  .doc(widget.uid)
                                                  .collection("friends")
                                                  .doc(myId)
                                                  .update({
                                                'status': "friend",
                                                'name': widget.myModel.name,
                                                'email': widget.myModel.email,
                                                'profile':
                                                    widget.myModel.profile,
                                                'chatId': "",
                                              }).whenComplete(() {
                                                Navigator.of(context).pop();
                                              });
                                            });
                                          },
                                          child: Text("Ok")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"))
                                    ],
                                  );
                                });
                          },
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Accept",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            //print(widget.friendModel.name);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Reject",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(fontSize: 10)),
                        )
                      ],
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
