import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/common.dart';

class NoteAnimatedTextBottomSheet extends StatelessWidget {
  const NoteAnimatedTextBottomSheet(
      {super.key,
      required this.textStyleCurrent,
      required this.textStyleNote,
      required this.fnCheck});
  final TextStyleEnum textStyleCurrent;
  final TextStyleEnum textStyleNote;
  final Function() fnCheck;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 300),
      style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: textStyleNote == textStyleCurrent
              ? FontWeight.w500
              : FontWeight.w300,
          color:
              textStyleNote == textStyleCurrent ? Colors.green : Colors.black),
      child: GestureDetector(
        onTap: fnCheck,
        child: Text(
          textStyleCurrent.toString(),
        ),
      ),
    );
  }
}
