// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, await_only_futures, camel_case_types

import 'package:con/components/mybutton.dart';
import 'package:con/components/mytextfield.dart';
import 'package:con/pages/navpage/homepage.dart';
import 'package:con/pages/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class helper {
  static Customdialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text(text), actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ]),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void check() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? c = await pref.getBool("statuslog");
    if (c == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  SignUpp(String gmail, String password) async {
    if (gmailController.text.isEmpty || passwordController.text.isEmpty || confirmpasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter the required fields"),
      ));
      return;
    }

    if (passwordController.text != confirmpasswordController.text) {
      helper.Customdialog(context, "Match both the passwords");
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: gmail, password: password);
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setBool("statuslog", true);
        gmailController.clear();
        passwordController.clear();
        confirmpasswordController.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      } on FirebaseAuthException catch (ex) {
        helper.Customdialog(context, ex.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(170),
            Icon(
              Icons.map_rounded,
              size: 130,
              color: Color.fromRGBO(133, 127, 247, 1),
            ),
            const Center(
              child: Text(
                "Create account",
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
            const Gap(20),
            mytextfield(Controller: gmailController, hinttext: "Email", obscureText: false, keyboardtype: TextInputType.emailAddress),
            const Gap(10),
            mytextfield(Controller: passwordController, hinttext: "Password", obscureText: true, keyboardtype: TextInputType.text),
            const Gap(10),
            mytextfield(Controller: confirmpasswordController, hinttext: "Confirm Password", obscureText: true, keyboardtype: TextInputType.text),
            const Gap(20),
            Mybutton(
              ontap: () {
                SignUpp(gmailController.text.toString(), passwordController.text.toString());
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
              },
              buttontext: "Sign Up",
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("have account?",style: TextStyle(color: Colors.white),),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('signin'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
