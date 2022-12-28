import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/string/icons.dart';
import 'package:note_app/core/theme/app_font.dart';
import 'package:note_app/features/note/presentation/bloc/notes_bloc.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_image.dart';
import '../../../domain/entites/note.dart';
import '../../pages/notes_add_page.dart';
import 'notes_enter_password_dialog.dart';

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
            Future.delayed(const Duration(milliseconds: 500), () {
              context.read<NotesBloc>().add(ChangePinNodeEvent(
                  uuid: note.uuid, isPin: note.isPin == 0 ? 1 : 0));
            });
          },
          trailingIcon: CupertinoIcons.pin,
          child: Text(note.isPin == 0 ? 'Pin' : 'UnPin'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 500), () {
              context.read<NotesBloc>().add(ChangeIsPasswordNoteEvent(
                  uuid: note.uuid, isPassword: note.isPassword == 0 ? 1 : 0));
            });
          },
          trailingIcon: CupertinoIcons.lock,
          child: Text(note.isPassword == 0 ? 'Lock' : 'UnLock'),
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
          if (note.isPassword == 1) {
            _builDialogStick(context, const EnterPasswordDialog());
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteAddPage(
                        isCheckEdit: true,
                        noteEdit: note,
                        heroTag: note.uuid,
                      )),
            );
          }
        }),
        child: Stack(
          children: [
            if (note.indexImage >= 0) ...{
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: SvgPicture.asset(
                  listImage[note.indexImage],
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),
              )
            },
            Container(
              decoration: BoxDecoration(
                color: note.indexImage >= 0
                    ? listColors[note.indexColor].withOpacity(0)
                    : listColors[note.indexColor],
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
                        note.title.isNotEmpty
                            ? Flexible(
                                flex: 8,
                                child: FittedBox(
                                  child: Text(note.title,
                                      style: GoogleFonts.getFont(
                                          listFont[note.indexFont],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Color(note.colorText))),
                                ),
                              )
                            : const Flexible(flex: 8, child: Text('')),
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
                    if (note.listCheck.isNotEmpty) ...{
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: note.listCheck.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Material(
                                  color: note.indexImage >= 0
                                      ? listColors[note.indexColor]
                                          .withOpacity(0)
                                      : listColors[note.indexColor],
                                  child: SizedBox(
                                    height: 40,
                                    child: CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: FittedBox(
                                        child: Text(note.listCheck[index].text,
                                            style: GoogleFonts.getFont(
                                                listFont[note.indexFont],
                                                fontSize: note.sizeText - 10,
                                                color: Color(note.colorText))),
                                      ),
                                      onChanged: null,
                                      value: note.listCheck[index].isCheck == 0
                                          ? false
                                          : true,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    },
                    note.body.isNotEmpty
                        ? Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    child: Text(note.body,
                                        style: GoogleFonts.getFont(
                                            listFont[note.indexFont],
                                            fontWeight: FontWeight.w500,
                                            color: Color(note.colorText))),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Text(''),
                  ],
                ),
              ),
            ),
            if (note.isPassword == 1) ...{
              Container(
                decoration: BoxDecoration(
                  color: listColors[note.indexColor].withOpacity(0.98),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: Image.asset(
                  LOCK_ICON,
                  fit: BoxFit.contain,
                )),
              )
            }
          ],
        ),
      ),
    );
  }

  MainAxisAlignment getTextAlign(String textAlign) {
    if (textAlign == "Left") return MainAxisAlignment.start;
    if (textAlign == "Right") return MainAxisAlignment.spaceAround;

    return MainAxisAlignment.center;
  }

  _builDialogStick(context, Widget widgetChild) {
    return showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
            scale: curve,
            child: widgetChild,
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }
}
