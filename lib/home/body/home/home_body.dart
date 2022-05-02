import 'package:flutter/material.dart';
import 'package:pay/home/body/online_friends/online_friends_list.dart';
import 'package:pay/sign_up/page_title.dart';
import '../chat_nav_chat/chated_friens.dart';

class HomeNavigationBody extends StatelessWidget {
  final String myId;
  const HomeNavigationBody({Key? key, required this.myId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color(0xFFF7F3F0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30.0, left: 10),
            child: PageTitle(
              title: "Massage",
              leftPad: 1.1,
              titleColor: Colors.black54,
            ),
          ),
          OnlineFriendsList(myId: myId),
          const Padding(
            padding: EdgeInsets.only(top: 30.0, left: 10),
            child: PageTitle(
              title: "Chats",
              size: 30,
              leftPad: 1.1,
              titleColor: Colors.black45,
            ),
          ),
          ChatedFriend(myId: myId),
        ],
      ),
    );
  }
}
