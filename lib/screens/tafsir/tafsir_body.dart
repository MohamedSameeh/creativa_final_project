import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/cubit/quraan_cubit/quraan_cubit.dart';
import 'package:muslim/model/quraan_model.dart';

class TafsirBody extends StatelessWidget {
  const TafsirBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the arguments and handle potential null/type issues
    final args = ModalRoute.of(context)?.settings.arguments as Surahs;

    // if (args is Surahs) {
    //   surahNumber = args.surahNumber;
    //   surahName = args.surahName;
    // } else {
    //   // Handle error case
    //   return Scaffold(body: Center(child: Text('Invalid surah number')));
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('تفسير ${args.surahName}'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade800, Colors.teal.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<TafsirResult>>(
          future: context.read<QuraanCubit>().getTafsir(
            surahNumber: args.surahNumber,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No tafsir available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final tafsirList = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tafsirList.length,
              itemBuilder: (context, index) {
                final tafsir = tafsirList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'آية ${tafsir.aya}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          tafsir.arabicText,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 2,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                        const Divider(height: 24),
                        Text(
                          tafsir.translation,
                          style: const TextStyle(fontSize: 18, height: 1.5),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
