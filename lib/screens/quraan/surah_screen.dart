import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/model/quraan_model.dart';

class SurahScreen extends StatelessWidget {
  const SurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Surahs;

    // Create a list to hold processed ayahs
    List<Ayahs> processedAyahs = [];

    // Add Bismillah for all surahs except At-Tawbah (9)
    if (args.surahNumber != 9) {
      processedAyahs.add(
        Ayahs(
          ayahNumber: 0,
          ayahText: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
        ),
      );
    }

    // Process ayahs
    if (args.ayahs.isNotEmpty) {
      // Bismillah variations
      final bismillahVariations = ['بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ '];

      // Process first ayah
      Ayahs firstAyah = args.ayahs.first;

      // Debug print
      print('Original first ayah text: ${firstAyah.ayahText}');

      // Create a modified first ayah
      Ayahs modifiedFirstAyah;

      // Check and remove Bismillah
      if (args.surahNumber != 9) {
        // Try each variation
        String modifiedText = firstAyah.ayahText;
        for (var variation in bismillahVariations) {
          if (modifiedText.startsWith(variation)) {
            modifiedText = modifiedText.replaceFirst(variation, '').trim();
            break;
          }
        }

        modifiedFirstAyah = Ayahs(
          ayahNumber: firstAyah.ayahNumber,
          ayahText: modifiedText,
        );

        // Debug print
        print('Modified first ayah text: ${modifiedFirstAyah.ayahText}');
      } else {
        modifiedFirstAyah = firstAyah;
      }

      // Add modified first ayah and rest of the ayahs
      processedAyahs.add(modifiedFirstAyah);
      processedAyahs.addAll(args.ayahs.skip(1));
    }

    return Scaffold(
      body: Container(
        color: Colors.deepPurple.shade900,
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context, args),
            _buildSurahContent(processedAyahs),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Surahs args) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          args.surahName,
          style: GoogleFonts.philosopher(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  args.surahEnglishName,
                  style: GoogleFonts.amiri(
                    textStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Verses: ${args.ayahs.length}',
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSurahContent(List<Ayahs> ayahs) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      sliver: Container(
        child: SliverList(
          delegate: SliverChildBuilderDelegate((
            BuildContext context,
            int index,
          ) {
            final ayah = ayahs[index];
            return _buildAyahCard(ayah, index);
          }, childCount: ayahs.length),
        ),
      ),
    );
  }

  Widget _buildAyahCard(Ayahs ayah, int index) {
    // Special styling for Bismillah
    if (ayah.ayahNumber == 0) {
      return Container(
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(44, 7, 52, 75).withOpacity(1),
              Colors.orange.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            ayah.ayahText,
            textAlign: TextAlign.center,
            style: GoogleFonts.amiri(
              textStyle: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 202, 16, 234).withOpacity(0.2),
            Colors.blue.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          ayah.ayahText,
          textAlign: TextAlign.right,
          style: GoogleFonts.amiri(
            textStyle: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
