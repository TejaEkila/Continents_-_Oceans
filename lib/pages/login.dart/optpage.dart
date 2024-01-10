// ignore_for_file: await_only_futures, must_be_immutable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:con/components/mybutton.dart';
import 'package:con/components/mytextfield.dart';
import 'package:con/pages/navpage/navbar.dart';

import 'package:con/pages/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OptPage extends StatefulWidget {
  String verificationid;
  OptPage({super.key, required this.verificationid});

  @override
  State<OptPage> createState() => _OptPageState();
}

class _OptPageState extends State<OptPage> {
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        mytextfield(
          Controller: otpController,
          hinttext: "opt",
          obscureText: false,
          keyboardtype: TextInputType.phone,
          prefix: null,
        ),
        const Gap(30),
        Mybutton(
            ontap: () async {
              try {
                PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: otpController.text);
                await FirebaseAuth.instance.signInWithCredential(credential);
                final currentUser = FirebaseAuth.instance.currentUser;

                if (currentUser != null) {
                  final snapshot = await FirebaseFirestore.instance.collection("new").doc(currentUser.uid).get();

                  if (snapshot.exists) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return BottomBar();
                    }));
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return WelcomePage();
                    }));
                  }
                } else {
                  // Handle the case where currentUser is null
                  print("Error: currentUser is null");
                }
              } catch (e) {
                // Handle authentication failure
                print("Authentication failed: $e");
              }
            },
            buttontext: "submit")
      ]),
    );
  }
}
