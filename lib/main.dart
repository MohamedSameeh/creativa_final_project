import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muslim/blocobserver.dart';
import 'package:muslim/constants.dart';
import 'package:muslim/cubit/add_note_cubit/add_note_cubit.dart';
import 'package:muslim/cubit/general_news_cubit/general_news_cubit.dart';
import 'package:muslim/cubit/news_app_cubit/news_app_cubit.dart';
import 'package:muslim/cubit/notes_cubit/notes_cubit.dart';
import 'package:muslim/cubit/quraan_cubit/quraan_cubit.dart';
import 'package:muslim/model/note_model.dart';
import 'package:muslim/widgets/news_app/aricle_details.dart';
import 'package:muslim/screens/azkar/azkar_body.dart';
import 'package:muslim/screens/categories/business.dart';
import 'package:muslim/screens/categories/entertainment.dart';
import 'package:muslim/screens/categories/general.dart';
import 'package:muslim/screens/categories/health.dart';
import 'package:muslim/screens/categories/science.dart';
import 'package:muslim/screens/categories/sports.dart';
import 'package:muslim/screens/categories/technology.dart';
import 'package:muslim/screens/main_screen.dart';
import 'package:muslim/screens/quraan/surah_screen.dart';
import 'package:muslim/screens/tafsir/tafsir_body.dart';
import 'package:muslim/screens/tafsir/tafsir_screen.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = Blocobserver();
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>(kNotesBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuraanCubit()..getSurahs()),
        BlocProvider(create: (context) => NewsAppCubit()),
        BlocProvider(create: (context) => GeneralNewsCubit()..getGeneralNews()),
        BlocProvider(create: (context) => NotesCubit()..fetchAllNotes()),
        BlocProvider(create: (context) => AddNoteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        home: MainScreen(),
        routes: {
          "bussiness": (context) {
            context.read<NewsAppCubit>().getNews(
              query: 'category',
              queryValue: 'business',
            );
            return BusinessPage();
          },
          "Entertainment": (context) {
            context.read<NewsAppCubit>().getNews(
              query: 'category',
              queryValue: 'entertainment',
            );
            return EntertainmentPage();
          },
          "general": (context) {
            context.read<NewsAppCubit>().getNews(
              query: 'category',
              queryValue: 'general',
            );
            return GeneralPage();
          },
          "health": (context) {
            context.read<NewsAppCubit>().getNews(
              query: 'category',
              queryValue: 'health',
            );
            return HealthPage();
          },
          "science": (context) {
            context.read<NewsAppCubit>().getNews(
              query: 'category',
              queryValue: 'science',
            );
            return SciencePage();
          },
          "sports": (context) {
            context.read<NewsAppCubit>().getNews(
              query: 'category',
              queryValue: 'sports',
            );
            return SportsPage();
          },
          "technology": (context) {
            context.read<NewsAppCubit>().getNews(
              query: 'category',
              queryValue: 'technology',
            );
            return TechnologyPage();
          },
          "articleDetails": (context) => ArticleDetails(),
          'surahScreen': (context) => SurahScreen(),
          'tafsirScreen': (context) => TafsirScreen(),
          'tafsirBody': (context) => TafsirBody(),
          'azkarBody': (context) => AzkarBody(),
        },
      ),
    );
  }
}
