// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String googlefont;
  final TextEditingController controller;
  final Color textColor;
  final Color borderColor;
  final TextInputType inputType;
  final bool obscureText;
  final FocusNode focusNode;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final bool isExpand;
  final int isImage;

  const CustomTextField(
      {super.key,
      this.hint = "Type text here...",
      this.googlefont = "Roboto",
      required this.controller,
      this.textColor = Colors.black,
      this.borderColor = Colors.black,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      required this.focusNode,
      this.fontSize = 24.0,
      this.fontWeight = FontWeight.w400,
      this.textAlign = TextAlign.center,
      this.isExpand = false,
      this.isImage = 0});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    if (widget.isImage == 1) {
      currentColor = widget.borderColor.withOpacity(0);
    } else {
      currentColor = widget.borderColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: currentColor,
      child: TextField(
        focusNode: widget.focusNode,
        obscureText: widget.obscureText,
        style: GoogleFonts.getFont(widget.googlefont,
            color: widget.textColor,
            fontWeight: widget.fontWeight,
            fontSize: widget.fontSize),
        textAlign: widget.textAlign,
        keyboardType: widget.inputType,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: currentColor),
          ),
          focusColor: currentColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: currentColor,
            ),
          ),
        ),
        maxLines: null,
        expands: widget.isExpand,
      ),
    );
  }
}
