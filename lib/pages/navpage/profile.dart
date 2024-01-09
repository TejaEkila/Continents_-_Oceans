import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:con/pages/login.dart/gmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("users").doc(user?.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("error:${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        var data = snapshot.data?.data();

        if (data == null || data.isEmpty) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 250),
            child: Text(
              "No data available",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ));
        }
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 840,
                  width: 430,
                  decoration: BoxDecoration(
                    //color: Colors.blueAccent,
                    
                  ),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1590273466070-40c466b4432d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dHJlZXMlMjBpbiUyMGZvcmVzdHxlbnwwfHwwfHx8MA%3D%3D",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 320),
                      child: Stack(
                        children: [
                          Container(
                            height: 520,
                            width: 430,
                            decoration: BoxDecoration(color: Color.fromRGBO(133, 127, 247, 1), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(120))),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(40),
                                Text("Name"),
                                Row(
                                  children: [
                                    Text(
                                      "${data['Firstname']}",
                                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),
                                    ),
                                    Gap(10),
                                    Text("${data['lastname']}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white)),
                                  ],
                                ),
                                Gap(10),
                                Text("Date of Brith"),
                                Gap(10),
                                Text("${data["dataofbrith"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white)),
                                Gap(10),
                                Text("profession"),
                                Gap(10),
                                Text("${data["profession"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white)),
                                Gap(10),
                                Text("Bio"),
                                Gap(10),
                                Text("${data['Bio']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white)),
                               Gap(90),
                               GestureDetector(
                                onTap: ()async{
                                  await FirebaseAuth.instance.signOut();
              SharedPreferences pref =
                  await SharedPreferences.getInstance();
              await pref.setBool("statuslog", false);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => 
                  GmailLink()));
                                },
                                 child: Container(
                                                       height: 70,
                                                       width: 300,
                                                       
                                                       decoration: BoxDecoration(
                                                         color: Colors.black,
                                                         borderRadius: BorderRadius.circular(20)
                                                         ),
                                                         child: Center(child: Text("Logout",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),)),
                                                     ),
                               )
                              ],
                            ),
                          ),
                          

                          //Text("ty${data['lastname']}"),
                        ],
                      ),
                    ),
                   
                  ],
                )
              ],
            )
          ],
        );
      },
    ));
  }
}
