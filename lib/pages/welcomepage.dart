// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:con/components/mybutton.dart';
import 'package:con/components/mytextfield.dart';
import 'package:con/pages/navpage/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final age = TextEditingController();
  final dob = TextEditingController();
  final profession = TextEditingController();
  final bio = TextEditingController();
  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    age.dispose();
    dob.dispose();
    profession.dispose();
    bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(70),
            Container(
              height: 200,
              width: 280,
              //color: Colors.amber,
              child: Center(child: LottieBuilder.asset("assets/write.json",fit: BoxFit.cover,)),
            ),
            const Text(
              "Enter your detials!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.white),
            ),
            const Gap(20),
            mytextfield(Controller: firstname, hinttext: "First Name", obscureText: false, keyboardtype: TextInputType.text, prefix: null,),
            const Gap(10),
            mytextfield(Controller: lastname, hinttext: "Last Name", obscureText: false, keyboardtype: TextInputType.text, prefix: null,),
            const Gap(10),
            mytextfield(Controller: age, hinttext: "Age", obscureText: false, keyboardtype: TextInputType.text,prefix: null,),
            const Gap(10),
            mytextfield(Controller: dob, hinttext: "Date of Brith", obscureText: false, keyboardtype: TextInputType.text,prefix: null,),
            const Gap(10),
            mytextfield(Controller: profession, hinttext: "eg:Student", obscureText: false, keyboardtype: TextInputType.text,prefix: null,),
            const Gap(20),
            mytextfield(Controller: bio, hinttext: "bio", obscureText: false, keyboardtype: TextInputType.text,prefix: null,),
            const Gap(20),
            Mybutton(
                ontap: () async {
                  print("working");
                  if (firstname.text.isEmpty || lastname.text.isEmpty || age.text.isEmpty || dob.text.isEmpty || profession.text.isEmpty || bio.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Fill all fields'),
                    ));
                  } else {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await FirebaseFirestore.instance.collection("users").doc(user.uid).set(
                          {"Firstname": firstname.text, "lastname": lastname.text, "age": age.text, "dataofbrith": dob.text, "profession": profession.text, "Bio": bio.text, "date": DateTime.now()},
                          SetOptions(merge: true));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomBar(),
                        ),
                      );
                      firstname.clear();
                      lastname.clear();
                      age.clear();
                      dob.clear();
                      profession.clear();
                      bio.clear();
                      setState(() {});
                    }
                  }
                },
                buttontext: "Submit"),
          ],
        ),
      ),
    );
  }
}
