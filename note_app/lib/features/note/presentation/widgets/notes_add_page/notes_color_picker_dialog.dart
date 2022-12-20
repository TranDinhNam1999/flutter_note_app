// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class NoteColorPickerDialog extends StatelessWidget {
  NoteColorPickerDialog(
      {super.key,
      required this.dialogSelectColor,
      required this.textColorValueSetter});
  late Color dialogSelectColor;
  ValueSetter<Color> textColorValueSetter = (value) {};

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) => Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(69, 244, 67, 54),
              Color.fromARGB(69, 76, 175, 79),
              Color.fromARGB(76, 33, 149, 243),
              Color.fromARGB(96, 233, 30, 98),
              Color.fromARGB(92, 255, 235, 59),
              Color.fromARGB(88, 155, 39, 176),
              Color.fromARGB(87, 255, 153, 0)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ColorIndicator(
              width: 20,
              height: 20,
              borderRadius: 50,
              hasBorder: true,
              color: dialogSelectColor,
              elevation: 1,
              onSelect: () async {
                // Wait for the dialog to return color selection result.
                final Color newColor = await showColorPickerDialog(
                  // The dialog needs a context, we pass it in.
                  context,
                  // We use the dialogSelectColor, as its starting color.
                  dialogSelectColor,
                  title: Text('ColorPicker',
                      style: Theme.of(context).textTheme.titleLarge),
                  width: 40,
                  height: 40,
                  spacing: 0,
                  runSpacing: 0,
                  borderRadius: 0,
                  wheelDiameter: 165,
                  enableOpacity: true,
                  colorCodeHasColor: true,
                  pickersEnabled: <ColorPickerType, bool>{
                    ColorPickerType.wheel: true,
                  },
                  copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                    copyButton: true,
                    pasteButton: true,
                    longPressMenu: true,
                  ),
                  actionButtons: const ColorPickerActionButtons(
                    okButton: true,
                    closeButton: true,
                    dialogActionButtons: false,
                  ),
                  transitionBuilder: (BuildContext context,
                      Animation<double> a1,
                      Animation<double> a2,
                      Widget widget) {
                    final double curvedValue =
                        Curves.easeInOutBack.transform(a1.value) - 1.0;
                    return Transform(
                      transform: Matrix4.translationValues(
                          0.0, curvedValue * 200, 0.0),
                      child: Opacity(
                        opacity: a1.value,
                        child: widget,
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 400),
                  constraints: const BoxConstraints(
                      minHeight: 400, minWidth: 320, maxWidth: 320),
                );
                textColorValueSetter(newColor);
                setState(() => dialogSelectColor = newColor);
              }),
        ),
      ),
    );
  }
}
