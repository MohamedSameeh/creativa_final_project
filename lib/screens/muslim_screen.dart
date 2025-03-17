import 'package:flutter/material.dart';
import 'package:muslim/screens/azkar/azkar_screen.dart';
import 'package:muslim/screens/prayer_time/prayer_time.dart';
import 'package:muslim/screens/quraan/quraan_screen.dart';
import 'package:muslim/screens/reciters/reciter_screen.dart';
import 'package:muslim/screens/tafsir/tafsir_screen.dart';

class MuslimScreen extends StatelessWidget {
  const MuslimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "📖 Islamic Guide",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade900,
          elevation: 5,
          bottom: TabBar(
            isScrollable: true, // Allows scrolling if too many tabs
            indicatorColor: Colors.amber,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            tabs: [
              Tab(icon: Icon(Icons.menu_book), text: "Quran"),
              Tab(icon: Icon(Icons.person), text: "Reciters"),
              Tab(icon: Icon(Icons.library_books), text: "Tafsir"),

              Tab(icon: Icon(Icons.mosque), text: "Azkar"),
              Tab(icon: Icon(Icons.timer), text: "Prayer Times"),

              // Tab(icon: Icon(Icons.record_voice_over), text: "Hadith"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            QuraanScreen(), // Display Surah List
            RecitersApp(),
            TafsirScreen(), // Display Tafsir Explanatione
            AzkarScreen(),
            PrayerTime(),
            // BookmarksScreen(), // Display Bookmarked Ayahs
            // DuaScreen(), // Display Islamic Duas
            // HadithScreen(), // Display Hadith Collection
          ],
        ),
      ),
    );
  }
}
