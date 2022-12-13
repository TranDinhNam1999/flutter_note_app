import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/string/icons.dart';

class NotesCardHome extends StatelessWidget {
  const NotesCardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        // image: const DecorationImage(
        //   image: NetworkImage(
        //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        //   fit: BoxFit.cover,
        // ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5, top: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 9,
                  child: AutoSizeText('Học tiếng anh',
                      maxLines: 1,
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                Flexible(
                  flex: 2,
                  child: Image.asset(
                    PIN_ICON,
                  ),
                )
              ],
            ),
            Flexible(
                child: AutoSizeText('aaaaaaaaaaaaaaaaaaa',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
