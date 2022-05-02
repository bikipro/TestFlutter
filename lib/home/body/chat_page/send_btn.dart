import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendBtn extends StatelessWidget {
  final String title;
  final IconData icons;
  final VoidCallback call;
  const SendBtn(
      {key, required this.title, required this.icons, required this.call})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.yellow,
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      child: ElevatedButton(
        onPressed: () {}, // call,
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(
              Colors.yellow,
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            )),
        child: Ink(
          height: 37,
          width: 65,
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
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: GoogleFonts.baloo(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ))),
                Icon(
                  icons,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
