class Reciter {
  final int id;
  final String name;
  final List<Moshaf> moshafs;

  Reciter({required this.id, required this.name, required this.moshafs});

  factory Reciter.fromJson(Map<String, dynamic> json) {
    List<Moshaf> moshafList =
        (json['moshaf'] as List?)?.map((i) => Moshaf.fromJson(i)).toList() ??
        [];
    return Reciter(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Unknown",
      moshafs: moshafList,
    );
  }
}

class Moshaf {
  final int id;
  final String name;
  final String server;
  final List<int> surahList;

  Moshaf({
    required this.id,
    required this.name,
    required this.server,
    required this.surahList,
  });

  factory Moshaf.fromJson(Map<String, dynamic> json) {
    List<int> surahs = [];
    if (json['surah_list'] is String) {
      surahs =
          json['surah_list']
              .split(',')
              .map((e) => int.tryParse(e.trim()))
              .whereType<int>()
              .toList();
    } else if (json['surah_list'] is List) {
      surahs =
          json['surah_list']
              .map((e) => e is int ? e : int.tryParse(e.toString()) ?? -1)
              .where((e) => e > 0)
              .toList();
    }

    return Moshaf(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Unknown",
      server: json['server'] ?? "",
      surahList: surahs,
    );
  }
}
