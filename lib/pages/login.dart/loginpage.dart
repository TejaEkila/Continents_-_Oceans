// ignore_for_file: avoid_print

import 'package:con/components/mybutton.dart';
import 'package:con/components/mytextfield.dart';
import 'package:con/pages/login.dart/gmail.dart';
import 'package:con/pages/login.dart/optpage.dart';
import 'package:con/pages/login.dart/signup/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';




class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(200),
          const Text(
            "NAME",
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
          ),
          const Gap(40),
          mytextfield(
            Controller: mobileController,
            hinttext: "Mobile no",
            obscureText: false,
            keyboardtype: TextInputType.number,
          ),
          const Gap(10),
          Mybutton(
              ontap: () {
                print("working");
                FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verification, int? resendtoken) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OptPage(
                                    verificationid: verification,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (String verficationId) {},
                    phoneNumber: mobileController.text);
              },
              buttontext: "send otp"),
          const Gap(20),
          const Text(
            "Or",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GmailLink()));
                },
                child: SizedBox(
                  //color: Colors.blueAccent,
                  height: 55,
                  width: 55,
                  child: Image.asset(
                    "assets/gmail.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(35),
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  //color: Colors.blueAccent,
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    "assets/google.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have account,",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (contex) => const SignUp()));
                    },
                    child: const Text(
                      "sign up",
                      style: TextStyle(color: Color.fromRGBO(133, 127, 247, 1), fontSize: 17),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
