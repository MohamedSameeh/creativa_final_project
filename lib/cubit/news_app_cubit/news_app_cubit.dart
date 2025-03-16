import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/api_services/api_services.dart';
import 'package:muslim/cubit/news_app_cubit/news_app_states.dart';
import 'package:muslim/model/news_model.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(InitialState());
  List<NewsModel> articles = [];
  List<NewsModel> generalNews = [];
  getNews({required String query, required String queryValue}) async {
    ApiServices apiservices = ApiServices();
    emit(InitialState());
    try {
      var json = await apiservices.getHttp(query, queryValue);
      List<NewsModel> articles = [];
      for (var x in json['articles']) {
        articles.add(
          NewsModel(
            title: x['title'],
            description: x['description'],
            imageUrl: x['urlToImage'],
          ),
        );
      }
      emit(NewsLoaded(apiModel: articles));
    } catch (e) {
      emit(NewsFailure(errorMessage: e.toString()));
    }
  }
}
