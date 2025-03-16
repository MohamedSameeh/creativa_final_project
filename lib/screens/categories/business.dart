import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/widgets/news_app/article_item.dart';
import '../../cubit/news_app_cubit/news_app_cubit.dart';
import '../../cubit/news_app_cubit/news_app_states.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bussiness News',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<NewsAppCubit, NewsAppStates>(
        builder: (context, state) {
          if (state is NewsLoaded) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade300, Colors.purple.shade300],
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemBuilder: (context, index) {
                      return ArticleItem(apiModel: state.apiModel[index]);
                    },
                    itemCount: state.apiModel.length,
                  ),
                ],
              ),
            );
          } else if (state is NewsFailure) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Center(child: Text("Error: ${state.errorMessage}")),
                ),
              ],
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // @override
  // void initState() {
  //   getGeneralNews();
  //   super.initState();
  // }

  // getGeneralNews() async {
  //   Apiservices apiservices = Apiservices();
  //   data =
  //       (await apiservices.getHttp('category', 'business')) as List<ApiModel>;
  //   setState(() {});
  // }
}
