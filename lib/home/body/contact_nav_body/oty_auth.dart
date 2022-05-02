import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:pay/home/body/contact_nav_body/submit_otp.dart';

Future<String> sendOtp(String number, BuildContext context) async {
  String data = "";
  await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + number,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String id, int? token) {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const SubmitOtp()));
        data = "ok";
      },
      codeAutoRetrievalTimeout: (String fd) {});
  return data;
}

void veryfiOtp(String id, otp) {
  PhoneAuthCredential credential =
      PhoneAuthProvider.credential(verificationId: id, smsCode: otp);
}
