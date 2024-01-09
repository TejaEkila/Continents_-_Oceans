// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class Ocens extends StatefulWidget {
  const Ocens({Key? key}) : super(key: key);

  @override
  State<Ocens> createState() => _OcensState();
}

class _OcensState extends State<Ocens> {
  late List<dynamic> oceansData = [];

  @override
  void initState() {
    super.initState();
    loadoceansData();
  }

  Future<void> loadoceansData() async {
    try {
      String data = await rootBundle.loadString("lib/oceans.json");
      var jsonData = json.decode(data) as Map<String, dynamic>;
      print("Loaded JSON Data: $jsonData"); // Add this line for debugging
      setState(() {
        oceansData = jsonData['oceans'];
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Container(
          child: oceansData.isNotEmpty
              ? ListView.builder(
                  itemCount: oceansData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var ocean = oceansData[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OcensPage(ocean: ocean),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(3, 3),
                                    ),
                                  ],
                                ),
                                height: 179,
                                width: 430,
                                child: Image.network(ocean['link'], fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          // Container(
                          //   height: 20,
                          //   decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 167, 161, 142),
                          //     borderRadius: BorderRadius.only(
                          //       bottomRight: Radius.circular(20),
                          //       bottomLeft: Radius.circular(20),
                          //     ),
                          //   ),
                          //   child: Center(child: Text(ocean["name"])),
                          // )
                        ],
                      ),
                    );
                  },
                )
              : const Text("No data found"),
        ),
      ),
    );
  }
}

class OcensPage extends StatefulWidget {
  const OcensPage({Key? key, required this.ocean}) : super(key: key);
  final Map<String, dynamic> ocean;

  @override
  State<OcensPage> createState() => _OcensPageState();
}

class _OcensPageState extends State<OcensPage> {
  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
            child: Container(
              height: 430,
              width: 430,
              decoration: const BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
              child: Image.network(
                widget.ocean["link"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
              const Gap(30),
              Text(
                widget.ocean["name"],
                style: const TextStyle(fontSize: 30,color: Colors.white),
              ),
            ],
          ),
          const Gap(10),
         Container(
          height: 413,
          width: 413,
          
          decoration: BoxDecoration(
            color: const Color.fromRGBO(133, 127, 247, 1),
            borderRadius: BorderRadius.circular(10)
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                   const Text(
                            "Area :",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            widget.ocean['area'],
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Gap(10),
                          const Text(
                            "Depth :",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            widget.ocean['depth'],
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Gap(10),
                          const Text(
                            "Location :",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            widget.ocean['location'],
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Gap(10),
                          const Text(
                            "Notable_Features:",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            widget.ocean['notable_features'],
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Gap(10),
                          const Text(
                            "Environmental_Significance :",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            widget.ocean['environmental_significance'],
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Gap(10),
                          const Text(
                            "Fauna :",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            widget.ocean['fauna'],
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Gap(10),
                          const Text(
                            "History :",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            widget.ocean['history'],
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const Gap(30),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                          print("working");
                          launchURL(widget.ocean['wikipedia_link']);
                        },
                        child: Container(
                          height: 70,
                          width: 300,
                          decoration: BoxDecoration(color: const Color.fromARGB(255, 34, 34, 33), borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text(
                            "Know more",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ),
                      ),
                  ],
                ),
              ),
            ),
         )

         
        ],
      ),
    );
  }
}
