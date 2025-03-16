import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/api_services/api_services.dart';
import 'package:muslim/cubit/general_news_cubit/general_news_states.dart';
import 'package:muslim/model/news_model.dart';

class GeneralNewsCubit extends Cubit<GeneralNewsStates> {
  GeneralNewsCubit() : super(LoadingState());

  getGeneralNews() async {
    ApiServices apiservices = ApiServices();
    try {
      var json = await apiservices.getHttp('category', 'general');
      List<NewsModel> articles = [];
      emit(LoadingState());
      for (var x in json['articles']) {
        articles.add(
          NewsModel(
            title: x['title'],
            description: x['description'],
            imageUrl: x['urlToImage'],
          ),
        );
      }
      emit(LoadedState(apiModel: articles));
    } catch (e) {
      emit(LoadingFailureState(errorMessage: e.toString()));
    }
  }
}
