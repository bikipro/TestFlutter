import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDetail extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  //final formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey;

  FormDetail({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.rePasswordController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<FormDetail> createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> {
  int indexForField = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: const BoxDecoration(),
      //color: Colors.green,
      alignment: Alignment.center,
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Card(
              elevation: indexForField == 1 ? 5 : 0,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(6),
                height: 60,
                child: TextFormField(
                    controller: widget.nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name can't be empty";
                      }
                    },
                    onTap: () {
                      indexForField = 1;

                      setState(() {});
                    },
                    keyboardType: TextInputType.text,
                    decoration: decor("Name", Icons.person),
                    style: GoogleFonts.baloo2(
                        textStyle: const TextStyle(
                      color: Colors.black,
                    ))),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Card(
                elevation: indexForField == 2 ? 5 : 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 60,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email can't be empty";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Enter a valid email";
                        }
                      },
                      controller: widget.emailController,
                      onTap: () {
                        indexForField = 2;
                        setState(() {});
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: decor("Email", Icons.email),
                      style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                        color: Colors.black,
                      ))),
                )),
            const SizedBox(
              height: 6,
            ),
            Card(
              elevation: indexForField == 3 ? 5 : 0,
              child: Container(
                padding: EdgeInsets.all(6),
                height: 60,
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password can't be empty";
                      }
                      // } else if (!RegExp(
                      //        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      //     .hasMatch(value)) {
                      //   return "Please enter a valid password";
                      // }
                      else if (value.length < 6) {
                        return "Password should allast 6";
                      }
                    },
                    controller: widget.passwordController,
                    onTap: () {
                      indexForField = 3;
                      setState(() {});
                    },
                    keyboardType: TextInputType.text,
                    //obscureText: true,
                    decoration: decor("Password", Icons.lock),
                    style: GoogleFonts.baloo2(
                        textStyle: TextStyle(
                      color: Colors.black,
                    ))),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: indexForField == 4 ? 5 : 0,
              child: Container(
                padding: EdgeInsets.all(6),
                height: 60,
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password can't be empty";
                      } else if (widget.passwordController.text != value) {
                        return "password should match";
                      }
                    },
                    controller: widget.rePasswordController,
                    onTap: () {
                      indexForField = 4;
                      setState(() {});
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: decor("Re Enter Password", Icons.lock),
                    style: GoogleFonts.baloo2(
                        textStyle: TextStyle(
                      color: Colors.black,
                    ))),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration decor(String hint, IconData icon) {
    return InputDecoration(
        //labelText: hint,
        hintText: hint,
        contentPadding: EdgeInsets.all(5),
        //isDense: true,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon),
        ));
  }
}
