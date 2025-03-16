import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/api_services/api_services.dart';
import 'package:muslim/cubit/quraan_cubit/quraan_states.dart';
import 'package:muslim/model/quraan_model.dart';

class QuraanCubit extends Cubit<QuraanStates> {
  QuraanCubit() : super(InitialState());
  List<Surahs>? surahs; // Change to List
  PrayerTimes? prayerTimes;
  ApiServices apiServices = ApiServices();

  getSurahs() async {
    try {
      emit(InitialState()); // Show Loading Indicator
      surahs = await apiServices.getQuraanSurahs();
      emit(SurahsLoaded(surahs: surahs!)); // Emit Success State
    } catch (e) {
      emit(SurahsFailure(errorMessage: e.toString())); // Emit Failure State
    }
  }

  Future<List<TafsirResult>> getTafsir({required int surahNumber}) async {
    try {
      // Add debug print
      print('Fetching tafsir for surah: $surahNumber');

      // if (surahNumber <= 0 || surahNumber > 114) {
      //   throw Exception('Invalid surah number');
      // }

      final results = await apiServices.getTafsir(surahNumber: surahNumber);

      // Add debug print
      print('Fetched ${results.length} tafsir results');

      return results;
    } catch (e) {
      print('Error in getTafsir: $e');
      throw Exception('Failed to load tafsir: $e');
    }
  }

  Future<List<PrayerTimes>> getPrayerTimes() async {
    try {
      return await apiServices.prayerTime();
    } catch (e) {
      print('Error in Cubit: $e');
      return []; // Return empty list in case of error
    }
  }
}
