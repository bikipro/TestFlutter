import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pay/home/body/chat_page/chat_record_model.dart';
import 'package:pay/keep_login.dart';

class ChatLeft extends StatefulWidget {
  final ChatRecordModel record;
  final String chatId;
  const ChatLeft({
    Key? key,
    required this.chatId,
    required this.record,
  }) : super(key: key);

  @override
  State<ChatLeft> createState() => _ChatLeftState();
}

class _ChatLeftState extends State<ChatLeft> {
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Chats")
        .doc("Chats")
        .collection(widget.chatId)
        .doc(widget.record.msgId)
        .update({'isSeen': true});
  }

  bool showDate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 60,
      //constraints: BoxConstraints(maxWidth: 50, minWidth: 30),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.white,
            elevation: 2,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              splashColor: Colors.grey.shade300,
              onTap: () {
                if (widget.record.type == "img") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(
                          body: Center(
                              child: Image.network(widget.record.msg)))));
                } else {
                  setState(() {
                    showDate ? showDate = false : showDate = true;
                  });
                }
              },
              onLongPress: () {
                deleteSingleMassage(widget.record.msgId, widget.chatId);
              },
              child: widget.record.type == "img"
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      constraints:
                          const BoxConstraints(maxHeight: 250, maxWidth: 250),
                      child: Image.network(widget.record.msg))
                  : Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 7, bottom: 7, right: 10),
                      constraints: const BoxConstraints(maxWidth: 270),
                      child: Text(
                        widget.record.msg,
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 2),
            child: Text(
              showDate
                  ? DateFormat().format(DateTime.parse(
                      widget.record.time == null
                          ? DateTime.now().toString()
                          : widget.record.time.toDate().toString()))
                  : DateFormat.jm().format(DateTime.parse(
                      widget.record.time == null
                          ? DateTime.now().toString()
                          : widget.record.time.toDate().toString())),
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteSingleMassage(String msgId, String chatId) {
    String myId = KeepLogin.prefs.getString("myId").toString();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete this massage"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  //code for delete sms..
                  DocumentReference reference = FirebaseFirestore.instance
                      .collection("Chats")
                      .doc("Chats")
                      .collection(chatId)
                      .doc(msgId);
                  reference.get().then((value) {
                    if (value.get('deleteId') == widget.record.receiver) {
                      if (widget.record.type != "img") {
                        reference
                            .delete()
                            .whenComplete(() => Navigator.of(context).pop());
                      } else {
                        // delete image

                        FirebaseStorage.instance
                            .ref()
                            .child('chatedImages')
                            .child(chatId)
                            .child(msgId)
                            .delete()
                            .whenComplete(() {
                          reference
                              .delete()
                              .whenComplete(() => Navigator.of(context).pop());
                        });
                      }
                    } else {
                      reference.update({'deleteId': myId}).whenComplete(
                          () => Navigator.of(context).pop());
                    }
                  });
                },
              ),
              TextButton(
                child: const Text("Cancle"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
