class Surahs {
  final String surahName;
  final int surahNumber;
  final String revelationType;
  final String surahEnglishName;
  final List<Ayahs> ayahs;

  Surahs({
    required this.surahName,
    required this.surahNumber,
    required this.revelationType,
    required this.surahEnglishName,
    required this.ayahs,
  });
  factory Surahs.fromJson(json) {
    return Surahs(
      surahName: json['name'],
      surahNumber: json['number'],
      revelationType: json['revelationType'],
      surahEnglishName: json['englishName'],
      ayahs: List<Ayahs>.from(json['ayahs'].map((x) => Ayahs.fromJson(x))),
    );
  }
}

class Ayahs {
  final String ayahText;
  final int ayahNumber;

  Ayahs({required this.ayahText, required this.ayahNumber});

  factory Ayahs.fromJson(json) {
    return Ayahs(ayahText: json['text'], ayahNumber: json['number']);
  }
}

class TafsirResponse {
  final int code;
  final String status;
  final List<TafsirResult> result;

  TafsirResponse({
    required this.code,
    required this.status,
    required this.result,
  });

  factory TafsirResponse.fromJson(Map<String, dynamic> json) {
    return TafsirResponse(
      code: json['code'],
      status: json['status'],
      result:
          (json['result'] as List)
              .map((item) => TafsirResult.fromJson(item))
              .toList(),
    );
  }
}

class TafsirResult {
  final int id;
  final int sura;
  final int aya;
  final String arabicText;
  final String translation;

  TafsirResult({
    required this.id,
    required this.sura,
    required this.aya,
    required this.arabicText,
    required this.translation,
  });

  factory TafsirResult.fromJson(Map<String, dynamic> json) {
    return TafsirResult(
      id: json['id'] is String ? int.parse(json['id']) : json['id'],
      sura: json['sura'] is String ? int.parse(json['sura']) : json['sura'],
      aya: json['aya'] is String ? int.parse(json['aya']) : json['aya'],
      arabicText: json['arabic_text'],
      translation: json['translation'],
    );
  }
}

class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
  });
  factory PrayerTimes.fromJson(json) {
    return PrayerTimes(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
    );
  }
}
