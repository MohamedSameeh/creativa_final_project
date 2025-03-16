import 'package:muslim/model/news_model.dart';

class GeneralNewsStates {}

class LoadingState extends GeneralNewsStates {}

class LoadedState extends GeneralNewsStates {
  final List<NewsModel> apiModel;

  LoadedState({required this.apiModel});
}

class LoadingFailureState extends GeneralNewsStates {
  final String errorMessage;

  LoadingFailureState({required this.errorMessage});
}
