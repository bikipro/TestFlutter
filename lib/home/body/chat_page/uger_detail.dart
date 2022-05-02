import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getDetail(String uid) async {
  //print(uid + "-----");
  DocumentSnapshot document =
      await FirebaseFirestore.instance.collection("Users").doc(uid).get();
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //print(data['name']);
  return data;
}
