import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/notes_add_page.dart';

class NoteFloatingBottom extends StatelessWidget {
  const NoteFloatingBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => _buildActionSheet(context));
      },
      child: const Icon(Icons.add, size: 30, color: Colors.white),
    );
  }

  Widget _buildActionSheet(BuildContext context) => CupertinoActionSheet(
      title: const Text(
        'New note',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            'Text',
            style: GoogleFonts.roboto(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteAddPage(
                        isCheckEdit: false,
                      )),
            );
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            'Checklist',
            style: GoogleFonts.roboto(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteAddPage(
                        isCheckEdit: false,
                        isCheckList: true,
                      )),
            );
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Cancel',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold, color: Colors.red)),
        onPressed: () {
          Navigator.pop(context);
        },
      ));
}
