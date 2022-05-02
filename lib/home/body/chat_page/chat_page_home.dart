import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay/home/body/chat_page/chat_page_home_body.dart';
import 'package:pay/home/body/chat_page/chat_page_home_footer.dart';
import 'package:pay/home/body/chat_page/uger_detail.dart';
import 'package:pay/home/body/friend_model.dart';
import 'package:pay/home/body/friend_nav_body/friend_profile.dart';
import 'package:pay/home/push_notification_services/send_notification_api.dart';
import 'package:pay/keep_login.dart';
import 'package:uuid/uuid.dart';

class ChatPageHome extends StatefulWidget {
  final String uid;
  const ChatPageHome({Key? key, required this.uid}) : super(key: key);

  @override
  State<ChatPageHome> createState() => _ChatPageHomeState();
}

class _ChatPageHomeState extends State<ChatPageHome> {
  TextEditingController msgController = TextEditingController();
  String myId = "";
  bool isFirstTime = true;
  String chatedId = "";
  String token = "";
  String myName = KeepLogin.prefs.getString("myName").toString();
  FriendModel friendDetails = FriendModel();
  @override
  void initState() {
    myId = FirebaseAuth.instance.currentUser!.uid;
    // TODO: implement initState
    super.initState();
    getDetail(widget.uid).then((value) {
      friendDetails.id = widget.uid;
      friendDetails.name = value['name'];
      friendDetails.email = value['email'];
      friendDetails.profile = value['profile'];
      token = value['token'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // const Color(0xFFF7F3F0),
        elevation: 0,
        title: Title(
            color: Colors.black,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: friendDetails.profile != ""
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(friendDetails.profile),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        friendDetails.name[0],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
              title: Text(friendDetails.name),
              subtitle: Text(friendDetails.email),
              onTap: () {
                showChatedFriendDetail();
              },
            )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.call,
            ),
          )
        ],
      ),
      body: Container(
        color: const Color(0xFFF7F3F0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ChatPageHomeBody(
                myId: myId,
                uid: widget.uid,
              ),
              ChatPageHomeFooter(
                msgController: msgController,
                callback: sendMsgs,
                callback2: sendMsgs,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sendMsgs(String catagory) async {
    String sms = msgController.text;
    String type = "msg";
    bool isPass = isPassed();
    File img = File("");
    if (catagory == "img") {
      img = await picImg();
      if (img.isAbsolute) {
        isPass = true;
      }
    }
    if (isPass) {
      String msgId = const Uuid().v4();
      //String sms = msgController.text;
      CollectionReference chatReference =
          FirebaseFirestore.instance.collection("Chats");
      if (isFirstTime) {
        CollectionReference chatedReference =
            FirebaseFirestore.instance.collection("Friend");
        final s = await chatedReference
            .doc(myId)
            .collection("friends")
            .doc(widget.uid)
            .get();

        if (s.data()!['chatId'] != "") {
          chatedId = s.data()!['chatId'];
          isFirstTime = false;
          if (catagory == "img") {
            type = "img";
            sms = await uploadImage(img, msgId, chatedId);
          }
          chatReference.doc("Chats").collection(chatedId).doc(msgId).set({
            'msg': sms,
            'sender': myId,
            'type': type,
            'receiver': widget.uid,
            'isSeen': false,
            'deleteId': "",
            'time': FieldValue.serverTimestamp()
          });
          if (token != "") {
            SendNotification().send(sms, myName, token);
          }
        } else {
          chatedId = const Uuid().v4();
          if (catagory == "img") {
            type = "img";
            sms = await uploadImage(img, msgId, chatedId);
          }
          chatedReference
              .doc(myId)
              .collection('friends')
              .doc(widget.uid)
              .update({'chatId': chatedId}).whenComplete(() {
            chatedReference
                .doc(widget.uid)
                .collection('friends')
                .doc(myId)
                .update({'chatId': chatedId}).whenComplete(() {
              isFirstTime = false;
              chatReference.doc("Chats").collection(chatedId).doc(msgId).set({
                'msg': sms,
                'sender': myId,
                'type': type,
                'receiver': widget.uid,
                'isSeen': false,
                'deleteId': "",
                'time': FieldValue.serverTimestamp()
              }).whenComplete(() {
                if (token != "") {
                  SendNotification().send(sms, myName, token);
                }
                setState(() {});
              });
            });
          });
        }
      } else {
        if (catagory == "img") {
          type = "img";
          sms = await uploadImage(img, msgId, chatedId);
        }
        chatReference.doc("Chats").collection(chatedId).doc(msgId).set({
          'msg': sms,
          'sender': myId,
          'type': type,
          'receiver': widget.uid,
          'isSeen': false,
          'deleteId': "",
          'time': FieldValue.serverTimestamp()
        });
        if (token != "") {
          SendNotification().send(sms, myName, token);
        }
      }
      msgController.clear();
    }
  }

  bool isPassed() {
    if (msgController.text.isNotEmpty && msgController.text != " ") {
      return true;
    } else {
      return false;
    }
  }

  Future<File> picImg() async {
    XFile? file;
    var file2;
    file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      final lastIndex = file.path.lastIndexOf(new RegExp(r'.jp'));
      final splitted = file.path.substring(0, (lastIndex));
      final outPath = "${splitted}_out${file.path.substring(lastIndex)}";
      file2 = await FlutterImageCompress.compressAndGetFile(file.path, outPath,
          quality: 35);
      return file2;
    } else {
      return File("");
    }
  }

  Future<String> uploadImage(File img, String msgId, String chatedId) async {
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('chatedImages')
        .child(chatedId)
        .child(msgId)
        .putFile(File(img.path));
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  void showChatedFriendDetail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FriendProfile(
                  detail: friendDetails,
                )));
  }
}
