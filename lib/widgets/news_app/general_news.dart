import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/cubit/general_news_cubit/general_news_cubit.dart';
import 'package:muslim/cubit/general_news_cubit/general_news_states.dart';
import 'package:muslim/widgets/news_app/article_item.dart';

class GeneralNews extends StatelessWidget {
  const GeneralNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralNewsCubit, GeneralNewsStates>(
      builder: (context, state) {
        if (state is LoadedState) {
          return SliverList.builder(
            itemBuilder: (context, index) {
              return ArticleItem(apiModel: state.apiModel[index]);
            },
            itemCount: state.apiModel.length,
          );
        } else if (state is LoadingFailureState) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Error : ${state.errorMessage}')),
          );
        } else {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
