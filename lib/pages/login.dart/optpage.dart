// ignore_for_file: await_only_futures, must_be_immutable

import 'dart:math';

import 'package:con/components/mybutton.dart';
import 'package:con/components/mytextfield.dart';
import 'package:con/pages/navpage/homepage.dart';
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
        ),
        const Gap(30),
        Mybutton(
            ontap: () async {
              try {
                PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: otpController.text);
                FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                });
              } catch (ex) {
                log(ex.toString() as num);
              }
            },
            buttontext: "sumbit")
      ]),
    );
  }
}
