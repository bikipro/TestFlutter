import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FromLogin extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> globalKey;
  FromLogin(
      {Key? key,
      required this.nameController,
      required this.passwordController,
      required this.globalKey})
      : super(key: key);

  @override
  State<FromLogin> createState() => FromLoginState();
}

class FromLoginState extends State<FromLogin> {
  int indexForField = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(),
      alignment: Alignment.center,
      child: Form(
        key: widget.globalKey,
        child: Column(
          children: [
            Card(
                //color: Colors.green,
                elevation: indexForField == 2 ? 5 : 0,
                child: Container(
                  padding: EdgeInsets.all(6),
                  height: 60,
                  //color: Colors.red,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a email";
                        }
                      },
                      controller: widget.nameController,
                      onTap: () {
                        indexForField = 2;
                        setState(() {});
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: decor("Email", Icons.email),
                      style: GoogleFonts.baloo2(
                          textStyle: TextStyle(
                        color: Colors.black,
                      ))),
                )),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: indexForField == 3 ? 5 : 0,
              child: Container(
                padding: EdgeInsets.all(6),
                height: 60,
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a email";
                      }
                    },
                    controller: widget.passwordController,
                    onTap: () {
                      indexForField = 3;
                      setState(() {});
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: decor("Password", Icons.lock),
                    style: GoogleFonts.baloo2(
                        textStyle: TextStyle(
                      color: Colors.black,
                    ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration decor(String hint, IconData icon) {
    return InputDecoration(
        labelText: hint,
        contentPadding: EdgeInsets.all(5),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon),
        ));
  }
}
