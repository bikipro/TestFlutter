import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pay/home/home.dart';
import 'package:pay/home/home_h.dart';
import 'package:pay/home/push_notification_services/local_notification_services.dart';
import 'package:pay/keep_login.dart';
import 'package:pay/logged_in/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KeepLogin.prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationServices.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: KeepLogin.prefs.getBool('login') == true
          ? Home(myId: KeepLogin.prefs.getString('myId').toString())
          : LoginPage(), //LoginPage(),
    );
  }
}
