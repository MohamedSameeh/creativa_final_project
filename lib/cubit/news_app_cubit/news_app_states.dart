import 'package:muslim/model/news_model.dart';

class NewsAppStates {}

class InitialState extends NewsAppStates {}

class NewsLoaded extends NewsAppStates {
  final List<NewsModel> apiModel;

  NewsLoaded({required this.apiModel});
}

class NewsFailure extends NewsAppStates {
  final String errorMessage;

  NewsFailure({required this.errorMessage});
}
