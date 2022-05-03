import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay/home/body/chat_page/chat_page_home.dart';

class OnlineFriendsRecordeLayout extends StatefulWidget {
  final List id;
  final String myId;
  const OnlineFriendsRecordeLayout(
      {Key? key, required this.id, required this.myId})
      : super(key: key);

  @override
  State<OnlineFriendsRecordeLayout> createState() =>
      _OnlineFriendsRecordeLayoutState();
}

class _OnlineFriendsRecordeLayoutState
    extends State<OnlineFriendsRecordeLayout> {
  @override
  Widget build(BuildContext context) {
    if (widget.id.isNotEmpty) {
      //!widget.id.isEmpty
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .where(FieldPath.documentId, whereIn: widget.id)
              .where("status", isEqualTo: "online")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: SizedBox(
                  height: 1,
                ),
              );
            } else {
              List<DocumentSnapshot> users = snapshot.data!.docs;

              return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  padding: const EdgeInsets.only(left: 15),
                  height: 70,
                  //color: Colors.blue,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          //height: 70,
                          width: 70,
                          child: InkWell(
                            onTap: () {
                              ChatPageHome(
                                uid: users[index].id,
                              );
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.green, width: 1),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                elevation: 3,
                                child: users[index]['profile'] != ""
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            users[index]['profile'].toString()))
                                    : CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Text(users[index]['name'][0]
                                            .toString()
                                            .toUpperCase()),
                                      )),
                          ),
                        );
                      }));
            }
          });
    } else {
      return SizedBox(height: 1);
    }
  }
}
