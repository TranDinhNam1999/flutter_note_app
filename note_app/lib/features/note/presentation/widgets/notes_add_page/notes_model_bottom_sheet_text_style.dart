import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/string/icons.dart';
import '../common/common.dart';
import 'notes_animated_text_bottom_sheet.dart';

// ignore: must_be_immutable
class NoteModelBottomSheetTextStyle extends StatelessWidget {
  NoteModelBottomSheetTextStyle(
      {super.key,
      required this.textStyleNote,
      required this.textStyleEnumValueSetter});
  TextStyleEnum textStyleNote;
  ValueSetter<TextStyleEnum> textStyleEnumValueSetter = (value) {};

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: Container(
        color: Colors.white,
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 12,
                    child: Text('Text style',
                        style: GoogleFonts.montserrat(
                            fontSize: 24, fontWeight: FontWeight.w400)),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        CHECK_ICON,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 150, 150, 150),
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: StatefulBuilder(
                builder: (BuildContext context, setState) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NoteAnimatedTextBottomSheet(
                      textStyleNote: textStyleNote,
                      textStyleCurrent: TextStyleEnum.small,
                      fnCheck: () {
                        textStyleEnumValueSetter(TextStyleEnum.small);
                        setState(() => textStyleNote = TextStyleEnum.small);
                      },
                    ),
                    NoteAnimatedTextBottomSheet(
                      textStyleNote: textStyleNote,
                      textStyleCurrent: TextStyleEnum.medium,
                      fnCheck: () {
                        textStyleEnumValueSetter(TextStyleEnum.medium);
                        setState(() => textStyleNote = TextStyleEnum.medium);
                      },
                    ),
                    NoteAnimatedTextBottomSheet(
                      textStyleNote: textStyleNote,
                      textStyleCurrent: TextStyleEnum.large,
                      fnCheck: () {
                        textStyleEnumValueSetter(TextStyleEnum.large);
                        setState(() => textStyleNote = TextStyleEnum.large);
                      },
                    ),
                    NoteAnimatedTextBottomSheet(
                      textStyleNote: textStyleNote,
                      textStyleCurrent: TextStyleEnum.huge,
                      fnCheck: () {
                        textStyleEnumValueSetter(TextStyleEnum.huge);
                        setState(() => textStyleNote = TextStyleEnum.huge);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 150, 150, 150),
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
