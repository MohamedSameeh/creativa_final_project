import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/cubit/notes_cubit/notes_cubit.dart';
import 'package:muslim/model/note_model.dart';
import 'package:muslim/screens/to_do/edit_note_view.dart';
import 'package:muslim/widgets/to_do_app/note_item.dart';

class NotesListview extends StatelessWidget {
  const NotesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesSuccess) {
          final notes = state.notes;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteView(notes: notes[index]),
                      ),
                    );
                  },
                  child: NoteItem(noteModel: notes[index]),
                );
              },
              itemCount: notes.length,
            ),
          );
        } else {
          return Center(child: Text('No notes available'));
        }
      },
    );
  }
}
