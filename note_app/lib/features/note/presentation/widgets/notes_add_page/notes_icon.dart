import 'package:flutter/material.dart';

class NoteIcon extends StatelessWidget {
  const NoteIcon({super.key, required this.nameIcon, required this.callback});
  final String nameIcon;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 8),
      child: GestureDetector(
          onTap: callback,
          child: SizedBox(height: 30, width: 30, child: Image.asset(nameIcon))),
    );
  }
}
