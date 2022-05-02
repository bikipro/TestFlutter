import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay/logged_in/login.dart';
import 'package:pay/sign_up/footer.dart';
import 'package:pay/sign_up/page_title.dart';

import 'button.dart';
import 'forme.dart';

class signup extends StatefulWidget {
  signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  GlobalKey<FormState> key1 = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF7F3F0),
          leading: Material(
            color: const Color(0xFFF7F3F0),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              splashColor: Colors.orange,
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.keyboard_return,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/img/background_ copy.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const PageTitle(title: "Create Account"),
                const SizedBox(
                  height: 50,
                ),
                FormDetail(
                  nameController: name,
                  emailController: email,
                  passwordController: password,
                  rePasswordController: rePassword,
                  formKey: key1,
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    alignment: Alignment.centerRight,
                    child: Buttons(
                      title: "SIGN UP",
                      icons: Icons.arrow_right,
                      call: () {
                        register(name.text, email.text, password.text,
                            rePassword.text);
                      },
                    )),
                const SizedBox(
                  height: 50,
                ),
                const Footer(),
              ],
            ),
          ),
        ));
  }

  void register(
      String name, String email, String password, String rePassword) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: CircularProgressIndicator(),
          );
        });
    if (key1.currentState!.validate()) {
      if (email != null && password != null && password == rePassword) {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          CollectionReference collection =
              FirebaseFirestore.instance.collection("Users");
          collection.doc(value.user?.uid).set({
            'name': name,
            'email': email,
            'status': "offline",
            'profile': "",
            'number': ""
          }).whenComplete(() => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage())));
        }).onError((error, stackTrace) {
          Navigator.of(context).pop();
        });
      }
    } else {
      print("no");
    }
  }
}
