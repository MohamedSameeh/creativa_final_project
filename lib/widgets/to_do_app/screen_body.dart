import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/cubit/notes_cubit/notes_cubit.dart';
import 'package:muslim/widgets/to_do_app/custom_app_bar.dart';
import 'package:muslim/widgets/to_do_app/note_item.dart';
import 'package:muslim/widgets/to_do_app/notes_listview.dart';

class ScreenBody extends StatefulWidget {
  const ScreenBody({super.key});

  @override
  State<ScreenBody> createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<ScreenBody> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        CustomAppBar(title: 'Notes'),
        Expanded(child: NotesListview()),
      ],
    );
  }
}
