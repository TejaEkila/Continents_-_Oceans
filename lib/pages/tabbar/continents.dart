// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:con/pages/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Continents extends StatefulWidget {
  const Continents({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContinentsState createState() => _ContinentsState();
}

class _ContinentsState extends State<Continents> {
  late List<dynamic> continentsData = [];

  @override
  void initState() {
    super.initState();
    loadContinentsData();
  }

  Future<void> loadContinentsData() async {
    try {
      String data = await rootBundle.loadString("lib/continents.json");
      var jsonData = json.decode(data) as Map<String, dynamic>;
      setState(() {
        continentsData = jsonData['continents'];
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
          child: continentsData.isNotEmpty
              ? GridView.builder(
                  itemCount: continentsData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var continent = continentsData[index];
                    var countries = continent['countries'] as List<dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Countery(countries: countries, continentData: continent)));
                              },
                              child: Container(
                                height: 179,
                                width: 300,
                                
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(133, 127, 247, 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 137, 137, 137).withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(3, 3),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  continent['link'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            
                            Container(
                              height: 20, 
                              color: Color.fromRGBO(133, 127, 247, 1), 
                              child: Center(
                                child: Text(continent['coname'],
                                style: TextStyle(color: Colors.white),
                                ),
                                ),
                                )
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                )
              : const Text("No data found"),
        ),
      ),
    );
  }
}

