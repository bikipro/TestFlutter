import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttons extends StatelessWidget {
  final String title;
  final IconData icons;
  final VoidCallback call;
  const Buttons(
      {key, required this.title, required this.icons, required this.call})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.yellow,
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      child: ElevatedButton(
        onPressed: call,
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(
              Colors.yellow,
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            )),

        // height: 50,
        // width: 100,
        child: Ink(
          height: 50,
          width: 130,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [
                  0.01,
                  0.7,
                ],
                colors: [
                  Colors.yellow,
                  Colors.orange,
                ]),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: GoogleFonts.baloo(
                        textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ))),
                Container(
                  child: Icon(
                    icons,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
