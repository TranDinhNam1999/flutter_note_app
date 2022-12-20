import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/string/icons.dart';
import '../../../../../core/theme/app_font.dart';
import '../common/common.dart';
import 'notes_animared_icon_bottom_sheet.dart';
import 'notes_animated_text_bottom_sheet.dart';
import 'notes_color_picker_dialog.dart';

// ignore: must_be_immutable
class NoteModelBottomSheetTextStyle extends StatelessWidget {
  NoteModelBottomSheetTextStyle(
      {super.key,
      required this.textStyleNote,
      required this.textStyleEnumValueSetter,
      required this.iconAlignNote,
      required this.iconAlignEnumValueSetter,
      required this.textColor,
      required this.textColorChangeValueSetter});
  TextStyleEnum textStyleNote;
  ValueSetter<TextStyleEnum> textStyleEnumValueSetter = (value) {};
  IconAlignEnum iconAlignNote;
  ValueSetter<IconAlignEnum> iconAlignEnumValueSetter = (value) {};
  Color textColor;
  ValueSetter<Color> textColorChangeValueSetter = (value) {};

  @override
  Widget build(BuildContext context) {
    var sizeText = Padding(
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
    );

    var alignIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: StatefulBuilder(
        builder: (BuildContext context, setState) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NoteAnimatedIconBottomSheet(
              iconAlignNote: iconAlignNote,
              iconAlignCurrent: IconAlignEnum.left,
              fnCheck: () {
                iconAlignEnumValueSetter(IconAlignEnum.left);
                setState(() => iconAlignNote = IconAlignEnum.left);
              },
            ),
            NoteAnimatedIconBottomSheet(
              iconAlignNote: iconAlignNote,
              iconAlignCurrent: IconAlignEnum.center,
              fnCheck: () {
                iconAlignEnumValueSetter(IconAlignEnum.center);
                setState(() => iconAlignNote = IconAlignEnum.center);
              },
            ),
            NoteAnimatedIconBottomSheet(
              iconAlignNote: iconAlignNote,
              iconAlignCurrent: IconAlignEnum.right,
              fnCheck: () {
                iconAlignEnumValueSetter(IconAlignEnum.right);
                setState(() => iconAlignNote = IconAlignEnum.right);
              },
            ),
            NoteColorPickerDialog(
              textColorValueSetter: (value) {
                textColorChangeValueSetter(value);
              },
              dialogSelectColor: textColor,
            )
          ],
        ),
      ),
    );
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
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listFont.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(listFont[index]),
                  );
                },
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 150, 150, 150),
              height: 2,
            ),
            sizeText,
            const Divider(
              color: Color.fromARGB(255, 150, 150, 150),
              height: 2,
            ),
            alignIcon,
          ],
        ),
      ),
    );
  }
}
