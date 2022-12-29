import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/notes_bloc.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late bool newpasswordVisible = true;
  late bool confirmpasswordVisible = true;
  late bool oldpasswordVisible = true;
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
          if (state.status == NoteStatus.changePasswordInCorrectOld) {
            errorText = "Password old is not correct";
          }
          if (state.status == NoteStatus.changePasswordInCorrectConfirm) {
            errorText = "Password confirm is not correct";
          }
          if (state.status == NoteStatus.changePasswordSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            alignment: FractionalOffset.center,
            height: 350,
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
                    _buildHeaderDialog(),
                    _buildOldPassword(),
                    _buildNewPassword(),
                    _buildConfirmPassword(),
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

  Widget _buildHeaderDialog() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Change  Password',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
          )
        ],
      );

  Widget _buildOldPassword() => Row(
        children: [
          Flexible(
            child: TextField(
              obscuringCharacter: '*',
              controller: _oldPasswordController,
              obscureText: oldpasswordVisible,
              decoration: InputDecoration(
                hintText: "Type old password",
                labelText: "Type old Password",
                helperStyle: const TextStyle(color: Colors.green),
                prefixIcon:
                    const IconButton(icon: Icon(Icons.lock), onPressed: null),
                suffixIcon: IconButton(
                  icon: Icon(
                    oldpasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        oldpasswordVisible = !oldpasswordVisible;
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

  Widget _buildNewPassword() => Row(
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

  Widget _buildConfirmPassword() => Row(
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
              context.read<NotesBloc>().add(ChangePasswordNoteEvent(
                  newPassword: _newPasswordController.text,
                  oldPassword: _oldPasswordController.text,
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
}
