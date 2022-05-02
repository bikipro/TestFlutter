import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final double size;
  final double leftPad;
  final Color titleColor;
  //final Style titleStyle;
  const PageTitle({
    Key,
    required this.title,
    this.size = 40,
    this.leftPad = 1.2,
    this.titleColor = Colors.black,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: MediaQuery.of(context).size.width / leftPad,
      //color: Colors.red,
      alignment: Alignment.topLeft,
      child: Text(title,
          style: GoogleFonts.baloo(
              textStyle: TextStyle(
            fontSize: size,
            color: titleColor,
          ))),
    );
  }
}
