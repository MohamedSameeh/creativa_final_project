import 'package:flutter/material.dart';
import 'package:muslim/model/reciters_model.dart';
import 'package:muslim/screens/reciters/surah_list_screen.dart';

class MoshafListScreen extends StatelessWidget {
  final Reciter reciter;
  final Function(String) playSurah;

  MoshafListScreen({required this.reciter, required this.playSurah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          reciter.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: reciter.moshafs.length,
          itemBuilder: (context, index) {
            final moshaf = reciter.moshafs[index];

            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                leading: Icon(
                  Icons.library_music,
                  color: Colors.green,
                  size: 30,
                ),
                title: Text(
                  moshaf.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  "عدد السور: ${moshaf.surahList.length}",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.green.shade700,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => SurahListScreen(
                            moshaf: moshaf,
                            // playSurah: playSurah,
                          ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
