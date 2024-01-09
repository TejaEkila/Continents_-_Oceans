// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:con/pages/navpage/homepage.dart';
import 'package:con/pages/navpage/likepage.dart';
import 'package:con/pages/navpage/profile.dart';
import 'package:flutter/material.dart';



class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const Likepage(),
    const ProfilePage(),
     
  ];

  void OnTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        unselectedItemColor: const Color.fromRGBO(133, 127, 247, 1),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        currentIndex: currentIndex,
        onTap: OnTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 116, 81, 35),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      
    );
  }
}
