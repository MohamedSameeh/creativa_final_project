import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muslim/constants.dart';
import 'package:muslim/cubit/notes_cubit/notes_cubit.dart';
import 'package:muslim/model/note_model.dart';
import 'package:muslim/widgets/to_do_app/add_note_bottomsheet.dart';
import 'package:muslim/widgets/to_do_app/add_note_form.dart';
import 'package:muslim/widgets/to_do_app/customTextfield.dart';
import 'package:muslim/widgets/to_do_app/custom_app_bar.dart';
import 'package:muslim/widgets/to_do_app/custom_app_bar_for_edit_view.dart';
import 'package:muslim/widgets/to_do_app/screen_body.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({super.key, required this.notes});
  final NotesModel notes;

  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        CustomAppBarForEditView(
          title: 'Edit Notes',
          onPressed: () {
            widget.notes.title = title ?? widget.notes.title;
            widget.notes.subTitle = content ?? widget.notes.subTitle;
            widget.notes.save();
            BlocProvider.of<NotesCubit>(context).fetchAllNotes();
            Navigator.pop(context);
          },
        ),
        SizedBox(height: 50),
        Customtextfield(
          title: widget.notes.title,
          maxLines: 1,
          onChanged: (value) {
            title = value;
          },
        ),
        Customtextfield(
          title: widget.notes.subTitle,
          maxLines: 5,
          onChanged: (value) {
            content = value;
          },
        ),
        ColorsListView(note: widget.notes),
      ],
    );
  }
}

class ColorsListView extends StatefulWidget {
  const ColorsListView({super.key, required this.note});
  final NotesModel note;
  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> {
  late int currentIndex;
  @override
  void initState() {
    currentIndex = kColors.indexOf(Color(widget.note.color));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      height: 38 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kColors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              currentIndex = index;
              widget.note.color = kColors[index].value;
              setState(() {});
            },
            child: ColorItem(
              isSelected: currentIndex == index,
              color: kColors[index],
            ),
          );
        },
      ),
    );
  }
}
