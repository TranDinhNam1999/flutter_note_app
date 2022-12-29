import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      required this.textColorChangeValueSetter,
      required this.fontTextCurrent,
      required this.fontTextChangeValueSetter});
  TextStyleEnum textStyleNote;
  ValueSetter<TextStyleEnum> textStyleEnumValueSetter = (value) {};
  IconAlignEnum iconAlignNote;
  ValueSetter<IconAlignEnum> iconAlignEnumValueSetter = (value) {};
  Color textColor;
  ValueSetter<Color> textColorChangeValueSetter = (value) {};
  String fontTextCurrent;
  ValueSetter<int> fontTextChangeValueSetter = (value) {};

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: Container(
        color: Colors.white,
        height: 200,
        child: Column(
          children: [
            _buildHeaderBottomSheet(context),
            _buildDivider(),
            _buildFontSize(),
            _buildDivider(),
            _buildSizeText(),
            _buildDivider(),
            _buildAlignIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBottomSheet(BuildContext context) => Padding(
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
      );

  Widget _buildDivider() => const Divider(
        color: Color.fromARGB(255, 150, 150, 150),
        height: 2,
      );

  Widget _buildAlignIcon() => Expanded(
        child: Padding(
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
        ),
      );

  Widget _buildFontSize() => StatefulBuilder(
        builder: (BuildContext context, setState) => Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listFont.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    fontTextChangeValueSetter(index);
                    setState(() => fontTextCurrent = listFont[index]);
                  },
                  child: Text(
                    listFont[index],
                    style: GoogleFonts.getFont(listFont[index],
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: fontTextCurrent == listFont[index]
                            ? Colors.green
                            : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
      );

  Widget _buildSizeText() => Expanded(
        child: Padding(
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
      );
}
