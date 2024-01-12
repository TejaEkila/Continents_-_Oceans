// ignore_for_file: await_only_futures, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:con/components/mybutton.dart';
import 'package:con/components/mytextfield.dart';
import 'package:con/pages/navpage/navbar.dart';
import 'package:con/pages/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OptPage extends StatefulWidget {
  String verificationID;
  OptPage({Key? key, required this.verificationID});

  @override
  State<OptPage> createState() => _OptPageState();
}

class _OptPageState extends State<OptPage> {
  final otpController = TextEditingController();
  String? _verificationCode;
  bool isLoading = false; // Add loading state

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone_number();
  }

  verifyPhone_number() async {
    print(widget.verificationID);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.verificationID,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
          final User? user = FirebaseAuth.instance.currentUser;
          final uid = user!.uid;
          print("########${uid}");
          var currentUser = await FirebaseFirestore.instance.collection("users").doc(uid).get();
          if (currentUser.exists) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return const BottomBar();
            }));
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return WelcomePage(
                phoneID:widget.verificationID
              );
            }));
          }
        });
      },
      verificationFailed: (FirebaseAuthException s) async {
        print(s);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog();
            });
      },
      codeSent: (String? verificationID, int? resendToken) {
        setState(() {
          print("><>>>>>>>>>>${verificationID}");
          _verificationCode = verificationID;
        });
      },
      codeAutoRetrievalTimeout: ((String verificationID) {
        setState(() {
          _verificationCode = verificationID;
        });
      }),
      timeout: Duration(seconds: 60),
    );
  }

 Future<void> submitOtp() async {
    final credential = PhoneAuthProvider.credential(verificationId: _verificationCode!, smsCode: otpController.text);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      final curentuser = FirebaseAuth.instance.currentUser;
      final snapshot = await FirebaseFirestore.instance.collection("users").doc(curentuser!.uid).get();
      if (snapshot.exists) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BottomBar();
          },
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return WelcomePage(
              phoneID:widget.verificationID,
            );
          },
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          mytextfield(
            Controller: otpController,
            hinttext: "otp",
            obscureText: false,
            keyboardtype: TextInputType.phone,
            prefix: null,
          ),
          const Gap(30),
          Mybutton(
            ontap: () async {
              setState(() {
                isLoading = false;
              });
              submitOtp();
            },
            buttontext: isLoading ? "Loading..." : "Submit",
          )
        ]),
      ),
    );
  }
}
