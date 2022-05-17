import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pay/home/body/chat_page/chat_record_model.dart';
import 'package:pay/keep_login.dart';

class ChatRight extends StatefulWidget {
  final ChatRecordModel record;
  final String chatId;
  const ChatRight({
    Key? key,
    required this.record,
    required this.chatId,
  }) : super(key: key);

  @override
  State<ChatRight> createState() => _ChatRightState();
}

class _ChatRightState extends State<ChatRight> {
  bool showDate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(3),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
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
                              body: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Image.network(widget.record.msg),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent.withOpacity(0.2),
                                  ),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    //mainAxisSize: MainAxisSize.min,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat().format(DateTime.parse(
                                            widget.record.time == null
                                                ? DateTime.now().toString()
                                                : widget.record.time
                                                    .toDate()
                                                    .toString())),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 4, top: 0, right: 4),
                                        child: widget.record.isSeen
                                            ? const Icon(
                                                Icons.done_all,
                                                color: Colors.green,
                                                size: 20,
                                              )
                                            : const Icon(
                                                Icons.done_all,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))));
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
                      padding: const EdgeInsets.all(5.0),
                      constraints:
                          const BoxConstraints(maxHeight: 250, maxWidth: 250),
                      child: Image.network(widget.record.msg))
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, top: 7, bottom: 7),
                          constraints: const BoxConstraints(maxWidth: 270),
                          child: Text(
                            widget.record.msg,
                            style: GoogleFonts.montserrat(),
                          ),
                        ),
                        showDate
                            ? Container(
                                padding: const EdgeInsets.only(
                                    left: 4, top: 0, right: 4),
                                child: widget.record.isSeen
                                    ? const Icon(
                                        Icons.done_all,
                                        color: Colors.green,
                                        size: 15,
                                      )
                                    : const Icon(
                                        Icons.done_all,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                              )
                            : const SizedBox(
                                width: 20,
                              ),
                      ],
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
                  //code for delete..
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
