import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pay/home/body/contact_nav_body/oty_auth.dart';
import 'package:pay/sign_up/page_title.dart';

import 'submit_otp.dart';

class VerifyNumber extends StatefulWidget {
  final Function callback;
  VerifyNumber({Key? key, required this.callback}) : super(key: key);

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  final TextEditingController phoneNoController = TextEditingController();
  bool isSend = false;
  bool isClick = false;
  String code = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFF7F3F0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
            child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.all(10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const PageTitle(
                title: "Get All Contacts",
                size: 20,
              ),
              isSend
                  ? SubmitOtp(
                      code: code,
                      number: phoneNoController.text,
                      callback: widget.callback,
                    )
                  : Column(
                      children: [
                        const Text(
                            "Please enter phone number to get friend from contact"),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: TextField(
                            controller: phoneNoController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: "Phone No.",
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: isClick
                                ? null
                                : () {
                                    String number = phoneNoController.text;
                                    if (number.isNotEmpty &&
                                        number.length == 10) {
                                      setState(() {
                                        isClick = true;
                                      });

                                      FirebaseAuth.instance.verifyPhoneNumber(
                                          phoneNumber:
                                              "+91" + phoneNoController.text,
                                          timeout: const Duration(seconds: 60),
                                          verificationCompleted:
                                              (PhoneAuthCredential
                                                  credential) {},
                                          verificationFailed:
                                              (FirebaseAuthException e) {
                                            print("error");
                                            isSend = false;
                                            isClick = false;
                                            setState(() {});
                                          },
                                          codeSent: (String id, int? token) {
                                            code = id;
                                            isSend = true;
                                            setState(() {});
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (context) => const SubmitOtp()));
                                          },
                                          codeAutoRetrievalTimeout:
                                              (String fd) {
                                            isSend = false;
                                            isClick = false;
                                            setState(() {});
                                          });
                                      setState(() {});
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Enter a valid number",
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                    }
                                  },
                            child: isClick
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text("Send"))
                      ],
                    ),
            ],
          ),
          elevation: 2,
        )));
  }
}
