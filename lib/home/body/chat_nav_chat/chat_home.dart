import 'package:flutter/material.dart';
import 'package:pay/home/body/friend_nav_body/friend_list.dart';
import 'package:pay/keep_login.dart';
import 'package:pay/sign_up/page_title.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  String myId = KeepLogin.prefs.getString("myId").toString();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFF7F3F0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 10),
              child: PageTitle(
                title: "Friends",
                titleColor: Colors.black54,
                leftPad: 1.1,
              ),
            ),
            FriendList(myId: myId),
          ],
        ));
  }
}
