import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/logged_in/login.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account",
              style: GoogleFonts.baloo2(
                  textStyle: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ))),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("Sign In",
                  style: GoogleFonts.baloo(
                      textStyle: const TextStyle(
                    fontSize: 20,
                  ))))
        ],
      ),
    );
  }
}
