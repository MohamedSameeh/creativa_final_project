import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:muslim/constants.dart';
import 'package:muslim/cubit/add_note_cubit/add_note_cubit.dart';
import 'package:muslim/cubit/notes_cubit/notes_cubit.dart';
import 'package:muslim/model/note_model.dart';
import 'package:muslim/widgets/to_do_app/customTextfield.dart';
import 'package:muslim/widgets/to_do_app/custom_button.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Customtextfield(
            title: 'Title',
            maxLines: 1,
            onSaved: (value) {
              title = value;
            },
          ),
          Customtextfield(
            title: 'Content',
            maxLines: 6,
            onSaved: (value) {
              subtitle = value;
            },
          ),
          SizedBox(height: 32),
          ColorsListView(),
          SizedBox(height: 16),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    var currentDate = DateTime.now();
                    var formattedDate = DateFormat(
                      'dd-MM-yyyy',
                    ).format(currentDate);

                    formKey.currentState!.save();
                    var noteModel = NotesModel(
                      title: title!,
                      subTitle: subtitle!,
                      date: formattedDate,
                      color: Colors.amberAccent.value,
                    );
                    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isSelected, required this.color});
  final bool isSelected;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return isSelected
        ? CircleAvatar(
          backgroundColor: Colors.white,
          radius: 38,
          child: CircleAvatar(radius: 36, backgroundColor: color),
        )
        : CircleAvatar(radius: 38, backgroundColor: color);
  }
}

class ColorsListView extends StatefulWidget {
  const ColorsListView({super.key});

  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> {
  int currentIndex = 0;

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
              BlocProvider.of<AddNoteCubit>(context).color = kColors[index];
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
