import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pay/home/body/friend_model.dart';

class SearchedData extends StatefulWidget {
  final FriendModel myDetail;
  final FriendModel friendModel;
  final String uid;
  final String myId;
  SearchedData(
      {Key? key,
      required this.myDetail,
      required this.friendModel,
      required this.uid,
      required this.myId})
      : super(key: key);

  @override
  State<SearchedData> createState() => _SearchedDataState();
}

class _SearchedDataState extends State<SearchedData> {
  @override
  void initState() {
    super.initState();
    isSelected = false;
    already_send = "";
    //already_sent_or_not();
  }

  String selectedId = "";
  bool isSelected = false;
  String already_send = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        height: 80,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: widget.friendModel.profile != ""
                        ? Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            elevation: 2,
                            child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.friendModel.profile)),
                          )
                        : Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            elevation: 2,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child:
                                  Text(widget.myDetail.name[0].toUpperCase()),
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.friendModel.name,
                    style: GoogleFonts.montserrat(fontSize: 20),
                  ),
                ],
              ),
              isSelected
                  ? Container(
                      child: setBtn(),
                    )
                  : SizedBox(
                      width: 1,
                    )
            ],
          ),
          onTap: () {
            final snapshot = FirebaseFirestore.instance
                .collection("Friend")
                .doc(widget.myId)
                .collection("friends")
                .doc(widget.uid);
            snapshot.get().then((value) {
              if (value.exists) {
                if (value.data()!['status'] == "send") {
                  already_send = "send";
                  isSelected = true;
                  setState(() {});
                } else if (value.data()!['status'] == "get") {
                  isSelected = true;
                  already_send = "get";
                  setState(() {});
                } else if (value.data()!['status'] == "friend") {
                  isSelected = true;
                  already_send = "friend";
                  setState(() {});
                }
              } else {
                already_send = "";
                isSelected = true;
                setState(() {});
              }
            });
            // isSelected = true;
            // setState(() {});
          },
        ),
      ),
    );
  }

  Widget setBtn() {
    if (already_send == "send") {
      already_send = "send";
      isSelected = true;
      return Text("Already send");
    } else if (already_send == "friend") {
      isSelected = true;
      return Text("Already Friend");
    } else if (already_send == "get") {
      isSelected = true;
      already_send = "get";
      return ElevatedButton(
          onPressed: () {
            if (already_send == "get") {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Do You want to Accept"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              CollectionReference reference = FirebaseFirestore
                                  .instance
                                  .collection("Friend");
                              reference
                                  .doc(widget.myId)
                                  .collection("friends")
                                  .doc(widget.uid)
                                  .update({
                                'status': "friend",
                                'name': widget.friendModel.name,
                                'email': widget.friendModel.email,
                                'profile': widget.friendModel.profile,
                                'chatId': "",
                              }).whenComplete(() {
                                print(widget.myId);
                                reference
                                    .doc(widget.uid)
                                    .collection("friends")
                                    .doc(widget.myId)
                                    .update({
                                  'status': "friend",
                                  'name': widget.myDetail.name,
                                  'email': widget.myDetail.email,
                                  'profile': widget.myDetail.profile,
                                  'chatId': "",
                                }).whenComplete(() {
                                  Navigator.of(context).pop();
                                  print(widget.uid);
                                  already_send = "friend";
                                  setState(() {});
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
            }
          },
          child: Text("Accept"));
    } else {
      already_send = "";
      isSelected = true;
      return ElevatedButton(
          onPressed: () {
            if (already_send == "") {
              CollectionReference reference =
                  FirebaseFirestore.instance.collection("Friend");
              reference
                  .doc(widget.uid)
                  .collection("friends")
                  .doc(widget.myId)
                  .set({
                'status': "get",
                'name': widget.myDetail.name,
                'email': widget.myDetail.email,
                'profile': widget.myDetail.profile
              }).whenComplete(() {
                reference
                    .doc(widget.myId)
                    .collection("friends")
                    .doc(widget.uid)
                    .set({
                  'status': "send",
                  'name': widget.friendModel.name,
                  'email': widget.friendModel.email,
                  'profile': widget.friendModel.profile
                }).whenComplete(() {
                  already_send = "send";
                  setState(() {});
                });
              });
            }
          },
          child: Text("Request"));
    }
  }
}
