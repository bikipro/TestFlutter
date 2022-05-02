import 'package:flutter/material.dart';

class ContactUserRecord extends StatefulWidget {
  final String uid;
  final String myId;
  final String name;
  final String phone;
  const ContactUserRecord(
      {Key? key,
      required this.uid,
      required this.myId,
      required this.name,
      required this.phone})
      : super(key: key);

  @override
  State<ContactUserRecord> createState() => _ContactUserRecordState();
}

class _ContactUserRecordState extends State<ContactUserRecord> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
