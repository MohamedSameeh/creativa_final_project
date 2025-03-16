import 'package:flutter/material.dart';
import 'package:muslim/constants.dart';
import 'package:muslim/widgets/to_do_app/add_note_bottomsheet.dart';

class Customtextfield extends StatelessWidget {
  const Customtextfield({
    super.key,
    required this.title,
    required this.maxLines,
    this.onSaved,
    this.onChanged,
  });
  final String title;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: maxLines,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Field is required';
          } else {
            return null;
          }
        },
        cursorColor: kPrimaryColor,

        decoration: InputDecoration(
          hintText: title,
          labelStyle: TextStyle(color: kPrimaryColor),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(kPrimaryColor),
          border: buildBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
