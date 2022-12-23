import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/theme/app_image.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/string/icons.dart';
import '../../../../../core/theme/app_color.dart';
import 'notes_tabbar_stick.dart';

// ignore: must_be_immutable
class NoteStickDialog extends StatelessWidget {
  NoteStickDialog(
      {super.key,
      required this.indexColorValueSetter,
      required this.indexImageValueSetter});
  ValueSetter<int> indexColorValueSetter = (value) {};
  ValueSetter<int> indexImageValueSetter = (value) {};

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
          alignment: FractionalOffset.center,
          height: 70.h,
          width: 85.w,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(CANCEL_ICON))),
                        Text('Stick note',
                            style: GoogleFonts.roboto(
                                fontSize: 22,
                                color: const Color.fromARGB(255, 100, 100, 100),
                                fontWeight: FontWeight.bold)),
                        const Text('')
                      ],
                    ),
                  ),
                ),
                NoteTabbarStick(
                    widgetColor: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: listColors.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (() {
                                Navigator.pop(context);
                                indexColorValueSetter(index);
                              }),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: listColors[index],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)))),
                            );
                          }),
                    ),
                    widgetPaper: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: listImage.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (() {
                                indexImageValueSetter(index);
                                Navigator.pop(context);
                              }),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 180,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0))),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: SvgPicture.asset(
                                      listImage[index],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )),
              ],
            ),
          )),
    );
  }
}
