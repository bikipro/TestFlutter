import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pay/home/body/contact_nav_body/contact_home.dart';
import 'package:pay/home/body/home/home_body.dart';
import 'package:pay/home/body/home/profile_in_appbar.dart';
import 'package:pay/home/push_notification_services/local_notification_services.dart';
import 'body/chat_nav_chat/chat_home.dart';

class Home extends StatefulWidget {
  final String myId;

  const Home({Key? key, required this.myId}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  bool wait = true;

  GlobalKey<CurvedNavigationBarState> navKey = GlobalKey();
  int pageIndex = 0;
  final pages = [HomeNav(), HomeNav(), ContactNavHome()]; //
  @override
  void initState() {
    super.initState();
    updateUserStatus();
    initialStateOfNotification();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.myId)
            .update({"status": "online"});
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.myId)
            .update({"status": "offline"});

        break;
      case AppLifecycleState.paused:
        FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.myId)
            .update({"status": "offline"});
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ProfileInAppbar(myId: widget.myId),
        body: pageIndex == 0
            ? HomeNavigationBody(
                myId: widget.myId,
              )
            : pages[pageIndex],
        bottomNavigationBar: CurvedNavigationBar(
          key: navKey,
          index: 0,
          height: 60,
          animationCurve: Curves.easeInOut,
          backgroundColor: Color(0xFFF7F3F0),
          animationDuration: Duration(milliseconds: 200),
          items: const [
            Icon(Icons.chat),
            Icon(Icons.group),
            Icon(Icons.contact_phone)
          ],
          onTap: (index) {
            print(index);
            pageIndex = index;
            setState(() {});
          },
        ) //FooterNavigation(),
        );
  }

  updateUserStatus() {
    print(widget.myId);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.myId)
        .update({"status": "online"}).whenComplete(() => print("completed"));
    WidgetsBinding.instance!.addObserver(this);
  }

  void initialStateOfNotification() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          LocalNotificationServices.createanddisplaynotification(message);
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationServices.createanddisplaynotification(message);
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationServices.createanddisplaynotification(message);
        }
      },
    );
  }
}
