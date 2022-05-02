import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pay/keep_login.dart';

class SubmitOtp extends StatefulWidget {
  final String code;
  final String number;
  final Function callback;
  const SubmitOtp(
      {Key? key,
      required this.code,
      required this.number,
      required this.callback})
      : super(key: key);

  @override
  State<SubmitOtp> createState() => _SubmitOtpState();
}

class _SubmitOtpState extends State<SubmitOtp> {
  bool isClick = false;
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: const Color(0xFFF7F3F0),
        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // const PageTitle(
            //   title: "Get All Contacts",
            //   size: 20,
            // ),
            const Text("Please enter otp"),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter otp",
                ),
              ),
            ),
            ElevatedButton(
                onPressed: isClick
                    ? null
                    : () async {
                        if (otpController.text.isNotEmpty &&
                            otpController.text.length == 6) {
                          setState(() {
                            isClick = true;
                          });
                          PhoneAuthCredential credential =
                              await PhoneAuthProvider.credential(
                                  verificationId: widget.code,
                                  smsCode: otpController.text);
                          if (credential.smsCode == otpController.text) {
                            FirebaseFirestore.instance
                                .collection("Users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({'number': widget.number}).whenComplete(
                                    () {
                              KeepLogin.prefs
                                  .setString(
                                      'contact', widget.number.toString())
                                  .then((value) => widget.callback());
                            });
                          } else {
                            setState(() {
                              isClick = false;
                            });
                            Fluttertoast.showToast(
                              msg: "You have ertred wrong otp",
                              toastLength: Toast.LENGTH_LONG,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Enter a valid otp",
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }

                        // FirebaseAuth.instance
                        //     .signInWithCredential(credential)
                        //     .then((value) => print("success"))
                        //     .onError((error, stackTrace) {
                        //   print(error);
                        // });
                      },
                child: isClick
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Next"))
          ],
        ));
  }
}
