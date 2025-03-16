import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:muslim/api_services/api_services.dart';
import 'package:muslim/model/reciters_model.dart';
import 'package:muslim/screens/reciters/moshaf_lists_screen.dart';

class RecitersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Reciter>> recitersFuture;
  List<Reciter> _allReciters = [];
  List<Reciter> _filteredReciters = [];
  TextEditingController _searchController = TextEditingController();
  AudioPlayer player = AudioPlayer();
  ApiServices apiServices = ApiServices();
  bool isPlaying = false;
  String? currentSurah;

  @override
  void initState() {
    super.initState();
    recitersFuture = apiServices.fetchReciters().then((reciters) {
      setState(() {
        _allReciters = reciters;
        _filteredReciters = reciters; // Initialize with all reciters
      });
      return reciters;
    });
  }

  void playSurah(String url) async {
    try {
      await player.stop();
      await player.play(UrlSource(url));
    } catch (e) {
      print("❌ خطأ في تشغيل الصوت: $e");
    }
  }

  void pauseSurah() async {
    await player.pause();
    setState(() => isPlaying = false);
  }

  void resumeSurah() async {
    await player.resume();
    setState(() => isPlaying = true);
  }

  void stopSurah() async {
    await player.stop();
    setState(() {
      isPlaying = false;
      currentSurah = null;
    });
  }

  void filterReciters(String query) {
    setState(() {
      _filteredReciters =
          _allReciters
              .where(
                (reciter) =>
                    reciter.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("القرآن الكريم - اختيار المقرئ"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "ابحث عن الشيخ...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: filterReciters,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Reciter>>(
              future: recitersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("فشل في تحميل البيانات"));
                } else if (_filteredReciters.isEmpty) {
                  return Center(child: Text("لم يتم العثور على نتائج"));
                }

                return ListView.builder(
                  itemCount: _filteredReciters.length,
                  itemBuilder: (context, index) {
                    final reciter = _filteredReciters[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(Icons.person, color: Colors.green),
                        title: Text(
                          reciter.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => MoshafListScreen(
                                    reciter: reciter,
                                    playSurah: playSurah,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
