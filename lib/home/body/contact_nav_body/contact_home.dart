import 'package:flutter/material.dart';
import 'package:pay/home/body/contact_nav_body/contact_users/contact_users.dart';
import 'package:pay/home/body/contact_nav_body/otp_verification/verify_number.dart';
import 'package:pay/home/body/contact_nav_body/oty_auth.dart';
import 'package:pay/home/body/contact_nav_body/otp_verification/submit_otp.dart';
import 'package:pay/keep_login.dart';
import 'package:pay/sign_up/page_title.dart';

class ContactNavHome extends StatefulWidget {
  const ContactNavHome({Key? key}) : super(key: key);

  @override
  State<ContactNavHome> createState() => _ContactNavHomeState();
}

class _ContactNavHomeState extends State<ContactNavHome> {
  //bool isSend = false;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     decoration: BoxDecoration(
    //       color: Colors.red,
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     height: 130,
    //     width: MediaQuery.of(context).size.width,
    //     child: Row(
    //       children: [
    //         ElevatedButton(onPressed: () {}, child: Text("Buy")),
    //         Column(
    //           children: [Text("Apple"), Text("20.0")],
    //         ),
    //       ],
    //     ));
    if (KeepLogin.prefs.getString('contact') != null) {
      return ContactUsers();
    } else {
      print(KeepLogin.prefs.getString('contact'));
      return VerifyNumber(
        callback: () {
          print("callback call");
          setState(() {});
        },
      );
    }
  }
}
