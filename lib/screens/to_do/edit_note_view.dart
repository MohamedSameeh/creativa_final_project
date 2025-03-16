import 'package:flutter/material.dart';
import 'package:muslim/model/note_model.dart';
import 'package:muslim/widgets/to_do_app/edit_note_body.dart';
import 'package:muslim/widgets/to_do_app/screen_body.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key, required this.notes});
  final NotesModel notes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditNoteViewBody(notes: notes));
  }
}
