import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/entites/note.dart';
import '../../bloc/notes_bloc.dart';
import '../../pages/notes_add_page.dart';

class EnterPasswordDialog extends StatefulWidget {
  const EnterPasswordDialog({super.key, required this.note});
  final Note note;

  @override
  State<EnterPasswordDialog> createState() => _EnterPasswordDialogState();
}

class _EnterPasswordDialogState extends State<EnterPasswordDialog> {
  final TextEditingController _newPasswordController = TextEditingController();
  late bool newpasswordVisible = true;
  late String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state.status == NoteStatus.enterPasswordInCorrect) {
            errorText = "Password is not correct";
          }

          if (state.status == NoteStatus.enterPasswordIsCorrect) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteAddPage(
                        isCheckEdit: true,
                        noteEdit: widget.note,
                        heroTag: widget.note.uuid,
                      )),
            );
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            alignment: FractionalOffset.center,
            height: 200,
            width: 80.w,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _headerDialog(),
                    _buildTextEnterPassword(),
                    if (errorText != "") ...{
                      Text(
                        errorText,
                        style: const TextStyle(color: Colors.red),
                      )
                    },
                    _buildFooterDialog()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _headerDialog() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enter Password',
              style: GoogleFonts.roboto(
                  fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          )
        ],
      );

  Widget _buildTextEnterPassword() => Row(
        children: [
          Flexible(
            child: TextField(
              obscuringCharacter: '*',
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.center,
              controller: _newPasswordController,
              obscureText: newpasswordVisible,
              decoration: const InputDecoration(
                helperStyle: TextStyle(color: Colors.green),
                alignLabelWithHint: false,
                filled: true,
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      );

  Widget _buildFooterDialog() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red)),
            child: Text(
              'Cancel',
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<NotesBloc>().add(EnterPasswordNoteEvent(
                  password: _newPasswordController.text));
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green)),
            child: Text('OK',
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )),
          )
        ],
      );
}
