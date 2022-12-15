import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/string/icons.dart';
import 'package:note_app/features/note/presentation/bloc/notes_bloc.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../domain/entites/note.dart';

class NotesCardHome extends StatelessWidget {
  const NotesCardHome({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: <Widget>[
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          trailingIcon: CupertinoIcons.heart,
          child: const Text('Pin'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 500), () {
              context.read<NotesBloc>().add(DeleteNoteEvent(uuid: note.uuid));
            });
          },
          isDestructiveAction: true,
          trailingIcon: CupertinoIcons.delete,
          child: const Text('Delete'),
        ),
      ],
      child: GestureDetector(
        onTap: (() {
          print('tap tap tap');
        }),
        child: Container(
          decoration: BoxDecoration(
            color: listColors[note.indexColor],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 5, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 9,
                      child: FittedBox(
                        child: Text(note.title,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),
                    ),
                    (note.isPin == 0)
                        ? const SizedBox(
                            width: 0,
                            height: 0,
                          )
                        : Flexible(
                            flex: 2,
                            child: Image.asset(
                              PIN_ICON,
                            ),
                          )
                  ],
                ),
                Flexible(
                    child: FittedBox(
                  child: Text(note.body,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}