import 'package:muslim/model/quraan_model.dart';

class QuraanStates {}

class SurahsLoaded extends QuraanStates {
  final List<Surahs?> surahs;

  SurahsLoaded({required this.surahs});
}

class SurahsFailure extends QuraanStates {
  final String errorMessage;

  SurahsFailure({required this.errorMessage});
}

class InitialState extends QuraanStates {}
