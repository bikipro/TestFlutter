import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRecordModel {
  String msg;
  String msgId;
  String receiver;
  String sender;
  String type;
  bool isSeen;
  Timestamp time;
  String deleteId;
  ChatRecordModel({
    required this.msg,
    this.msgId = "",
    this.receiver = "",
    this.sender = "",
    required this.type,
    this.isSeen = false,
    required this.time,
    this.deleteId = "",
  });
  //   ChatRecordModel(
  //     String msg, String rec, String sen, String type, Timestamp time) {
  //   this.msg = msg;
  //   this.receiver = rec;
  //   this.sender = sen;
  //   this.type = type;
  //   this.time = time;
  // }
}
