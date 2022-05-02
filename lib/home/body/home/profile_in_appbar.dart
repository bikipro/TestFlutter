import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/home/body/friend_model.dart';
import 'package:pay/home/header/friend_requeest/friend_request.dart';
import 'package:pay/keep_login.dart';
import 'package:pay/logged_in/login.dart';

import '../../header/profile/my_profile.dart';
import '../../header/search_friend/search_friend.dart';

class ProfileInAppbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80.0);
  final String myId;
  const ProfileInAppbar({Key? key, required this.myId}) : super(key: key);

  @override
  State<ProfileInAppbar> createState() => _ProfileInAppbarState();
}

class _ProfileInAppbarState extends State<ProfileInAppbar> {
  bool request = false;
  FriendModel myDetails = FriendModel();
  @override
  void initState() {
    super.initState();
    getMyDetail(widget.myId).then((value) {
      myDetails = value;
      if (KeepLogin.prefs.getString("myName") == null) {
        KeepLogin.prefs.setString("myName", myDetails.name);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      toolbarHeight: 80,
      elevation: 0,
      //backgroundColor: Color(0xFFF7F3F0),
      backgroundColor: Colors.white,
      leadingWidth: 90,
      title: Text(myDetails.name),

      leading: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyProfile(detail: myDetails, myId: widget.myId)));
          //
          //changeProfile();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: myDetails.profile == ""
              ? Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 2,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        myDetails.name[0].toUpperCase(),
                        style: GoogleFonts.actor(
                            textStyle: const TextStyle(
                                fontSize: 50, color: Colors.black)),
                      )),
                )
              : Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 2,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(myDetails.profile))),
        ),
      ),
      actions: [
        const Padding(padding: EdgeInsets.only(right: 50)),
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchFriend(
                          myId: widget.myId,
                        )));
          },
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RequestedFriend(myId: widget.myId)));
              },
              icon: const Icon(
                Icons.person_add_alt,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26, bottom: 13),
              child: Container(
                height: 10,
                width: 10,
                color: request ? Colors.green : Colors.white,
              ),
            )
          ],
        ),
        PopupMenuButton(itemBuilder: (BuildContext contex) {
          return [
            PopupMenuItem(
              child: Text("LogOut"),
              onTap: () {
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(widget.myId)
                    .update({
                  "status": "offline",
                  "number": "",
                  "token": "notLogedIn"
                });
                FirebaseAuth.instance.signOut().whenComplete(() {
                  //KeepLogin.prefs.setBool('login', false);
                  KeepLogin.prefs.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
            )
          ];
        })
      ],
    );
  }

  Future<FriendModel> getMyDetail(String myId) async {
    var model;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(myId)
        .get()
        .then((value) {
      if (value.data()!['number']! != "") {
        KeepLogin.prefs.setString('contact', value.data()!['number']);
      }
      model = FriendModel("", value.data()!['name'], value.data()!['email'],
          value.data()!['profile']);
    });
    return model;
  }

  friendRequest() {
    final u = FirebaseFirestore.instance
        .collection("Friend")
        .doc(widget.myId)
        .collection("friends")
        .where('status', isEqualTo: "get");
    u.get().then((value) {
      if (value.docs.isNotEmpty) {
        request = true;
        setState(() {});
      }
    });
  }
}
