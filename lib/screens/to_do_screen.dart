import 'package:flutter/material.dart';
import 'package:muslim/widgets/to_do_app/add_note_bottomsheet.dart';
import 'package:muslim/widgets/to_do_app/screen_body.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            context: context,
            builder: (context) {
              return AddNoteBottomsheet();
            },
          );
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      body: ScreenBody(),
    );
  }
}
