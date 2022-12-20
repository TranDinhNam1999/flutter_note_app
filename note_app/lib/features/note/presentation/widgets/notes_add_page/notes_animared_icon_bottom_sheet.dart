import 'package:flutter/material.dart';

import '../common/common.dart';

class NoteAnimatedIconBottomSheet extends StatelessWidget {
  const NoteAnimatedIconBottomSheet(
      {super.key,
      required this.iconAlignCurrent,
      required this.iconAlignNote,
      required this.fnCheck});
  final IconAlignEnum iconAlignCurrent;
  final IconAlignEnum iconAlignNote;
  final Function() fnCheck;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: fnCheck, child: getIcon(iconAlignCurrent, iconAlignNote));
  }

  Icon getIcon(IconAlignEnum icon, IconAlignEnum iconAlignNote) {
    if (icon == IconAlignEnum.center) {
      return Icon(
        Icons.format_align_center,
        color: iconAlignNote == iconAlignCurrent ? Colors.green : Colors.black,
      );
    }
    if (icon == IconAlignEnum.right) {
      return Icon(
        Icons.format_align_right,
        color: iconAlignNote == iconAlignCurrent ? Colors.green : Colors.black,
      );
    }

    return Icon(
      Icons.format_align_left,
      color: iconAlignNote == iconAlignCurrent ? Colors.green : Colors.black,
    );
  }
}
