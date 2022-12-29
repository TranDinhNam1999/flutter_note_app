import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/notes_bloc.dart';

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({super.key});

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late bool newpasswordVisible = true;
  late bool confirmpasswordVisible = true;
  late String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state.status == NoteStatus.changePasswordFailure) {
            errorText = "Password is not correct";
          }
          if (state.status == NoteStatus.changePasswordIsNotNullorEmpty) {
            errorText = "Password is not empty";
          }
          if (state.status == NoteStatus.changePasswordSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            alignment: FractionalOffset.center,
            height: 300,
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
                    _buildHearderDialog(),
                    _buildNewPassworDialog(),
                    _buildConfirmPassworDialog(),
                    // * Show error text
                    if (errorText != "") ...{
                      Text(
                        errorText,
                        style: const TextStyle(color: Colors.red),
                      )
                    },
                    _buildfooterDialog()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHearderDialog() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Password',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
          )
        ],
      );

  Widget _buildfooterDialog() => Row(
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
              context.read<NotesBloc>().add(NewPasswordNoteEvent(
                  newPassword: _newPasswordController.text,
                  confirmPassword: _confirmPasswordController.text));
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

  Widget _buildNewPassworDialog() => Row(
        children: [
          Flexible(
            child: TextField(
              obscuringCharacter: '*',
              controller: _newPasswordController,
              obscureText: newpasswordVisible,
              decoration: InputDecoration(
                hintText: "Type new password",
                labelText: "Type new Password",
                helperStyle: const TextStyle(color: Colors.green),
                prefixIcon:
                    const IconButton(icon: Icon(Icons.lock), onPressed: null),
                suffixIcon: IconButton(
                  icon: Icon(
                    newpasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        newpasswordVisible = !newpasswordVisible;
                      },
                    );
                  },
                ),
                alignLabelWithHint: false,
                filled: true,
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      );

  Widget _buildConfirmPassworDialog() => Row(
        children: [
          Flexible(
            child: TextField(
              obscuringCharacter: '*',
              controller: _confirmPasswordController,
              obscureText: confirmpasswordVisible,
              decoration: InputDecoration(
                hintText: "Confirm password",
                labelText: "Confirm Password",
                helperStyle: const TextStyle(color: Colors.green),
                prefixIcon:
                    const IconButton(icon: Icon(Icons.lock), onPressed: null),
                suffixIcon: IconButton(
                  icon: Icon(
                    confirmpasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        confirmpasswordVisible = !confirmpasswordVisible;
                      },
                    );
                  },
                ),
                alignLabelWithHint: false,
                filled: true,
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      );
}
