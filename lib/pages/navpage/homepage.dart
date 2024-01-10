import 'package:con/pages/tabbar/continents.dart';
import 'package:con/pages/tabbar/oceans.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          //.leading: const Icon(Icons.camera),
          title: const Text(
            'I N F O',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 23,
              color: Colors.white
            ),
          ),
          bottom: const TabBar(
            
            indicatorColor: Color.fromRGBO(133, 127, 247, 1), 
            indicatorSize: TabBarIndicatorSize.tab, 
            indicatorWeight:3, 
            unselectedLabelColor: Color.fromARGB(255, 104, 133, 147),
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500), tabs: [
            Tab(
              text: 'Continets',
            ),
            Tab(
              text: 'Ocens',
            ),
          ]),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(), 
          children: [
            Continents(), Ocens()
            ]
            ),
            
      ),
    );
  }
}
