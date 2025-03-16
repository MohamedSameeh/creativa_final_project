import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/cubit/quraan_cubit/quraan_cubit.dart';
import 'package:muslim/cubit/quraan_cubit/quraan_states.dart';

class QuraanScreen extends StatefulWidget {
  const QuraanScreen({super.key});

  @override
  _QuraanScreenState createState() => _QuraanScreenState();
}

class _QuraanScreenState extends State<QuraanScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    context.read<QuraanCubit>().getSurahs();
  }

  void _filterSurahs(String query, List<dynamic> surahs) {
    setState(() {
      if (query.isEmpty) {
        filteredSurahs = surahs;
      } else {
        filteredSurahs =
            surahs
                .where(
                  (surah) =>
                      surah.surahName.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      surah.surahEnglishName.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              _buildSearchBar(),
              Expanded(
                child: BlocBuilder<QuraanCubit, QuraanStates>(
                  builder: (context, state) {
                    if (state is SurahsLoaded) {
                      if (filteredSurahs.isEmpty) {
                        filteredSurahs =
                            state.surahs; // Initialize filtered list
                      }
                      return _buildSurahGrid(context, filteredSurahs);
                    } else if (state is SurahsFailure) {
                      return _buildErrorState(state);
                    } else {
                      return _buildLoadingState();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ' Holy Quran',
            style: GoogleFonts.philosopher(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: searchController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search Surahs...",
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(Icons.search, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (query) {
          _filterSurahs(
            query,
            context.read<QuraanCubit>().state is SurahsLoaded
                ? (context.read<QuraanCubit>().state as SurahsLoaded).surahs
                : [],
          );
        },
      ),
    );
  }

  Widget _buildSurahGrid(BuildContext context, List<dynamic> surahs) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        return _buildSurahCard(context, surah, index);
      },
    );
  }

  Widget _buildSurahCard(BuildContext context, dynamic surah, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'surahScreen', arguments: surah);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Positioned(
            //   top: 10,
            //   right: 10,
            //   child: Text(
            //     '${surah.surahNumber}',
            //     style: TextStyle(
            //       color: Colors.white.withOpacity(0.3),
            //       fontSize: 40,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    surah.surahName,
                    style: GoogleFonts.amiri(
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    surah.surahEnglishName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(height: 16),
          Text('Loading Surahs...', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildErrorState(SurahsFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 60),
          SizedBox(height: 16),
          Text(
            'Error Loading Surahs',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            state.errorMessage,
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              context.read<QuraanCubit>().getSurahs();
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
