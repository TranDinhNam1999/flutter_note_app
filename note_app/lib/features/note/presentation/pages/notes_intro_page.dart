import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/string/lotties.dart';
import '../../../../core/string/messages.dart';
import 'notes_home_page.dart';

class NotesIntro extends StatefulWidget {
  const NotesIntro({super.key});

  @override
  State<NotesIntro> createState() => _NotesIntroState();
}

class _NotesIntroState extends State<NotesIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'NOTELY',
                style: GoogleFonts.getFont('Titan One',
                    fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 70.w,
                  width: 85.w,
                  child: Lottie.asset(BOOK_INTRO, fit: BoxFit.contain)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  INTRO_MESSAGE,
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w800, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const NoteHomePage(),
                          ),
                        );
                      },
                      child: Text(
                        'GET STARTED',
                        style: GoogleFonts.nunito(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      )),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
