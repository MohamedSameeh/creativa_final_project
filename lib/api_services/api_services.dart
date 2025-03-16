import 'package:dio/dio.dart';
import 'package:muslim/model/quraan_model.dart';
import 'package:muslim/model/reciters_model.dart';

class ApiServices {
  Dio dio = Dio();
  final String baseUrl = 'https://newsapi.org/v2/top-headlines';
  final String apiKey = 'aab761deef8b4cd9a0386ed4942d2088';
  Future<Map<String, dynamic>> getHttp(String query, String queryValue) async {
    var response = await dio.get('$baseUrl?apiKey=$apiKey&$query=$queryValue');
    return response.data;
  }

  getQuraanSurahs() async {
    var response = await dio.get(
      'https://api.alquran.cloud/v1/quran/quran-uthmani',
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> json = response.data;
      List<dynamic> surahsJson = json['data']['surahs'];
      List<Surahs> apiModel =
          surahsJson.map((surah) => Surahs.fromJson(surah)).toList();
      return apiModel;
    } else {
      throw Exception("Failed to load Quran Surahs");
    }
  }

  Future<List<Reciter>> fetchReciters() async {
    String apiUrl = "https://mp3quran.net/api/v3/reciters?language=ar";
    final dio = Dio();

    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200 && response.data['reciters'] != null) {
        List<dynamic> recitersJson = response.data['reciters'];
        return recitersJson.map((json) => Reciter.fromJson(json)).toList();
      } else {
        throw Exception('فشل تحميل البيانات');
      }
    } catch (e) {
      print("خطأ أثناء تحميل البيانات: $e");
      throw Exception('حدث خطأ أثناء الاتصال بالسيرفر');
    }
  }

  Future<List<TafsirResult>> getTafsir({required int surahNumber}) async {
    try {
      // Add debug print
      print('Making API call for surah: $surahNumber');

      final response = await dio.get(
        'https://quranenc.com/api/v1/translation/sura/arabic_moyassar/$surahNumber',
      );

      // Add debug print
      print('API Response: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['result'];
        return results.map((item) => TafsirResult.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load tafsir');
      }
    } catch (e) {
      print('Error in API call: $e');
      throw Exception('Failed to load tafsir: $e');
    }
  }

  Future<List<PrayerTimes>> prayerTime() async {
    try {
      var response = await dio.get(
        'https://api.aladhan.com/v1/timingsByCity/08-03-2025?city=cairo&country=egypt',
      );

      // Access the timings from the nested structure
      Map<String, dynamic> data = response.data['data'];
      Map<String, dynamic> timings = data['timings'];

      // Create a PrayerTimes object directly
      return [
        PrayerTimes(
          fajr: timings['Fajr'] ?? '',
          sunrise: timings['Sunrise'] ?? '',
          dhuhr: timings['Dhuhr'] ?? '',
          asr: timings['Asr'] ?? '',
          sunset: timings['Sunset'] ?? '',
          maghrib: timings['Maghrib'] ?? '',
          isha: timings['Isha'] ?? '',
        ),
      ];
    } catch (e) {
      print('Error fetching prayer times: $e');
      return []; // Return empty list in case of error
    }
  }
}
