import 'package:flutter/material.dart';
import 'package:pay/logged_in/login.dart';
import 'package:pay/sign_up/footer.dart';
import 'package:pay/sign_up/page_title.dart';

import 'button.dart';
import 'forme.dart';

class ss extends StatelessWidget {
  const ss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF7F3F0),
          leading: Material(
            color: Color(0xFFF7F3F0),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 30,
                ),
                const PageTitle(title: "Create Account"),
                SizedBox(height: 50),
                // FormDetail(),
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    alignment: Alignment.centerRight,
                    child: Buttons(
                      title: "SIGN UP",
                      icons: Icons.arrow_right,
                      call: () {},
                    )),
                SizedBox(
                  height: 50,
                ),
                const Footer(),
              ],
            ),
          ),
        ));
  }
}
