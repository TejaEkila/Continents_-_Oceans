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
        backgroundColor:  Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          //.leading: const Icon(Icons.camera),
          title: const Text(
            'I N F O',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 23,
              color: Colors.black
            ),
          ),
          bottom: const TabBar(
            
            indicatorColor: Colors.blue, 
            indicatorSize: TabBarIndicatorSize.tab, 
            indicatorWeight:3, 
            unselectedLabelColor: Color.fromARGB(255, 104, 133, 147),
            labelColor: Colors.black,
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
