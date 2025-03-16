import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/cubit/general_news_cubit/general_news_cubit.dart';
import 'package:muslim/cubit/general_news_cubit/general_news_states.dart';
import 'package:muslim/widgets/news_app/categories.dart';
import 'package:muslim/widgets/news_app/general_news.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<GeneralNewsCubit>().getGeneralNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // Dark Blue

        title: Text(
          "News App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.green,
      body: BlocBuilder<GeneralNewsCubit, GeneralNewsStates>(
        builder: (context, state) {
          if (state is LoadedState) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: Categories()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "General News ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                GeneralNews(),
              ],
            );
          } else if (state is LoadingFailureState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
