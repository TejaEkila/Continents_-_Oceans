// ignore_for_file: deprecated_member_use



import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class Countery extends StatefulWidget {
  final List<dynamic> countries;
  final Map<String, dynamic> continentData;

  const Countery({Key? key, required this.countries, required this.continentData}) : super(key: key);

  @override
  State<Countery> createState() => _CounteryState();
}

class _CounteryState extends State<Countery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.continentData['coname'],
          style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Container(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: widget.countries.isNotEmpty
            ? GridView.builder(
                itemCount: widget.countries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  var country = widget.countries[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Con(
                                    selectedCountry: country,
                                    continentData: widget.continentData,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 179,
                              width: 300,
                              color: const Color.fromRGBO(133, 127, 247, 1),
                              child: Image.network(
                                country['lin'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            color: const Color.fromRGBO(133, 127, 247, 1),
                            child: Center(
                              child: Text(
                                country['name'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Container(),
      ),
    );
  }
}

class Con extends StatefulWidget {
  const Con({
    Key? key,
    required this.selectedCountry,
    required this.continentData,
  }) : super(key: key);

  final dynamic selectedCountry;
  final Map<String, dynamic> continentData;

  @override
  State<Con> createState() => _ConState();
}

class _ConState extends State<Con> {
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
              color: Colors.amber,
              child: Image.network(
                widget.selectedCountry['lin'],
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
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  )),
              const Gap(40),
              Text(
                widget.selectedCountry['name'],
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
          const Gap(5),
          Container(
              height: 413,
              width: 413,
              decoration: BoxDecoration(color: const Color.fromRGBO(133, 127, 247, 1), borderRadius: BorderRadius.circular(13)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(15),
                      const Text(
                        "Area :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['area'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(10),
                      const Text(
                        "Population :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['population'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(10),
                      const Text(
                        "States :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['states'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(10),
                      const Text(
                        "FamousThing :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['famousThing'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(10),
                      const Text(
                        "Food :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['food'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(10),
                      const Text(
                        "Animals :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['animals'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(10),
                      const Text(
                        "LandType :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['land'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(10),
                      const Text(
                        "AgricultureLandArea :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['agricultureLandArea'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(10),
                      const Text(
                        "About :",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        widget.selectedCountry['history'],
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Gap(30),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                          print("working");
                          launchURL(widget.selectedCountry['wikipediaLink']);
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
                      const Gap(30),
                    ],
                  ),
                ),
              )),
          const Gap(5),
        ],
      ),
    );
  }
}
