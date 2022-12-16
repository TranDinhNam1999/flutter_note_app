import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/string/icons.dart';
import '../../../../../core/theme/app_color.dart';

// ignore: must_be_immutable
class NoteStickDialog extends StatelessWidget {
  NoteStickDialog({super.key, required this.indexColorValueSetter});
  ValueSetter<int> indexColorValueSetter = (value) {};

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          alignment: FractionalOffset.center,
          height: 70.h,
          width: 85.w,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 243, 243),
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
                Expanded(
                  child: Padding(
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
                )
              ],
            ),
          )),
    );
  }
}
