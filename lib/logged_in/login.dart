import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/home/home.dart';
import 'package:pay/keep_login.dart';
import 'package:pay/logged_in/formLogin.dart';
import 'package:pay/sign_up/button.dart';
import 'package:pay/sign_up/page_title.dart';
import 'package:pay/sign_up/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passswordlController = TextEditingController();
  GlobalKey<FormState> keyGlobal = GlobalKey<FormState>();
  @override
  // void initState() {
  //   Firebase.initializeApp().whenComplete(() {
  //     print("Done");
  //     setState(() {

  //     });
  //   });
  // }
  String deviceTokenToSendPushNotification = "";

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/img/background_ copy.png"),
            fit: BoxFit.fill,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 130,
              ),
              const PageTitle(title: "Login"),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                //color: Colors.red,
                alignment: Alignment.topLeft,
                child: Text("Please Login To Continue",
                    style: GoogleFonts.baloo(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ))),
              ),
              const SizedBox(
                height: 60,
              ),
              FromLogin(
                nameController: emailController,
                passwordController: passswordlController,
                globalKey: keyGlobal,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  alignment: Alignment.centerRight,
                  child: Buttons(
                    title: "Login",
                    icons: Icons.login,
                    call: () {
                      register();
                    },
                  )),
              const SizedBox(
                height: 100,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account",
                      style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      )),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signup()));
                        },
                        child: Text("Sign Up",
                            style: GoogleFonts.baloo(
                                textStyle: const TextStyle(
                              fontSize: 20,
                            ))))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void register() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: SizedBox(
                height: 40, child: Center(child: CircularProgressIndicator())),
          );
        },
      );
      await auth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passswordlController.text)
          .then((value) async {
        String? uid = value.user?.uid;
        DocumentReference reference =
            FirebaseFirestore.instance.collection("Users").doc(uid);
        reference.get().then((value) async {
          if (value.get('token') != "notLogedIn") {
            //....
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title:
                      const Text("Your account is loged in on another device"),
                  actions: [
                    TextButton(
                      child: const Text("cancle"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text("continue"),
                      onPressed: () {
                        afterLogin(reference, uid);
                      },
                    ),
                  ],
                );
              },
            );
            //....
          } else {
            afterLogin(reference, uid);
          }
        });

        //User? user = FirebaseAuth.instance.currentUser;

        // if (user != null && !user.emailVerified) {
        //   var actionCodeSettings = ActionCodeSettings(
        //     url: 'https://www.example.com/?email=${user.email}',
        //     dynamicLinkDomain: 'example.page.link',
        //     androidPackageName: 'com.example.android',
        //     androidInstallApp: true,
        //     androidMinimumVersion: '12',
        //     iOSBundleId: 'com.example.ios',
        //     handleCodeInApp: true,
        //   );
        //   user.sendEmailVerification(actionCodeSettings);
        // }
      });
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(error.code),
            actions: [
              TextButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  Future<void> afterLogin(DocumentReference reference, String? uid) async {
    await getDeviceTokenToSendNotification();
    reference
        .update({'token': deviceTokenToSendPushNotification}).whenComplete(() {
      KeepLogin.prefs.setBool('login', true);
      KeepLogin.prefs.setString('myId', FirebaseAuth.instance.currentUser!.uid);
      //if(value.user?.)
      //KeepLogin.prefs.setString('contact', value)
      Navigator.of(context).pop();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home(myId: uid.toString())));
    });
  }
}
