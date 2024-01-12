import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:con/pages/login.dart/loginpage.dart';
import 'package:con/pages/navpage/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Server extends StatefulWidget {
  const Server({Key? key});

  @override
  State<Server> createState() => _ServerState();
}

class _ServerState extends State<Server> {
  @override
  void initState() {
    super.initState();
    // Start a timer to delay navigation after 30 seconds
    _startTimer();
  }

  _startTimer() async {
    await Future.delayed(Duration(seconds: 10));

    // Check login status and navigate accordingly
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? statuslog = pref.getBool("statuslog");

    final current = await FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance.collection("users").doc(current!.uid).get();

    if (snapshot.exists) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return BottomBar();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/loading.json"), // Replace with your actual animation file path
      ),
    );
  }
}
