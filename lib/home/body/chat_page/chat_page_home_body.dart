import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pay/home/body/chat_page/chat_left.dart';
import 'package:pay/home/body/chat_page/chat_record_model.dart';
import 'package:pay/home/body/chat_page/chat_right.dart';

class ChatPageHomeBody extends StatefulWidget {
  final String myId;
  final String uid;
  //final ScrollController controller;
  const ChatPageHomeBody({
    Key? key,
    required this.myId,
    required this.uid,
  }) : super(key: key);

  @override
  State<ChatPageHomeBody> createState() => _ChatPageHomeBodyState();
}

class _ChatPageHomeBodyState extends State<ChatPageHomeBody> {
  String chatId = "noId";
  @override
  void initState() {
    super.initState();

    getChatId();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height / 5.5,
      //color: const Color(0xFFF7F3F0),
      child: chatId != ""
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Chats")
                  .doc("Chats")
                  .collection(chatId)
                  .orderBy('time', descending: true)
                  .snapshots(),
              //initialData: initialData,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  List<DocumentSnapshot> docs = snapshot.data!.docs;
                  docs.reversed.toList();
                  return ListView.builder(
                    //controller: controller,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      //controller.jumpTo(controller.position.maxScrollExtent);
                      if (docs[index]['deleteId'] != widget.myId) {
                        if (docs[index]['sender'] == widget.myId) {
                          return ChatRight(
                            record: ChatRecordModel(
                                msg: docs[index]['msg'],
                                type: docs[index]['type'],
                                time: docs[index]['time'],
                                isSeen: docs[index]['isSeen'],
                                msgId: docs[index].id,
                                receiver: docs[index]['receiver']),
                            chatId: chatId,
                          );
                        } else {
                          return ChatLeft(
                              chatId: chatId,
                              record: ChatRecordModel(
                                  msg: docs[index]['msg'],
                                  type: docs[index]['type'],
                                  time: docs[index]['time'],
                                  msgId: docs[index].id,
                                  receiver: docs[index]['receiver']));
                        }
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                }
                return const Center(child: Text("Chats"));
              })
          : const Center(child: Text("Chats")),
    );
  }

  void getChatId() async {
    final reference1 =
        FirebaseFirestore.instance.collection("Friend").doc(widget.myId);
    //reference1.
    final reference = await reference1 //.doc(widget.myId)
        .collection('friends')
        .doc(widget.uid)
        .get();
    if (reference.exists) {
      setState(() {
        chatId = reference.data()!['chatId'];
      });
    }
  }
}
