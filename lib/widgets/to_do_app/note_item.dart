import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:muslim/cubit/notes_cubit/notes_cubit.dart';
import 'package:muslim/model/note_model.dart';
import 'package:muslim/screens/to_do/edit_note_view.dart';
import 'package:muslim/widgets/to_do_app/edit_note_body.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.noteModel});
  final NotesModel noteModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(noteModel.color),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              noteModel.title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            subtitle: Text(
              noteModel.subTitle,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.black54.withOpacity(0.4),
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: IconButton(
                icon: Icon(FontAwesomeIcons.trash, size: 30),
                color: Colors.black,
                onPressed: () async {
                  await noteModel.delete();
                  BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                },
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                noteModel.date,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 26,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
