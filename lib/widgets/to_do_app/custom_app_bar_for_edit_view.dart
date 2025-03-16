import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarForEditView extends StatelessWidget {
  const CustomAppBarForEditView({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.2),
          ),
          margin: EdgeInsets.only(right: 30),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.check, size: 30),
          ),
        ),
      ],
    );
  }
}
