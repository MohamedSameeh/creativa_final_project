import 'package:flutter/material.dart';
import 'package:muslim/screens/news_screen.dart';
import 'package:muslim/screens/muslim_screen.dart';
import 'package:flutter/material.dart';
import 'package:muslim/screens/news_screen.dart';
import 'package:muslim/screens/muslim_screen.dart';
import 'package:muslim/screens/to_do_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State {
  int currentIndex = 0;

  final List screens = [MuslimScreen(), NewsScreen(), ToDoScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple.shade900,
        fixedColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mosque, size: 30),
            label: 'Muslim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper, size: 30),
            label: 'NewsApp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes, size: 30),
            label: 'Notes',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
      ),
      body: screens[currentIndex],
    );
  }
}
