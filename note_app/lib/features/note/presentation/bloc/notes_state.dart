part of 'notes_bloc.dart';

enum NoteStatus {
  inital,
  loading,
  success,
  failure,
  deleteSuccess,
  addSuccess,
  updateSuccess,
  newPasswordSuccess,
  changePasswordSuccess,
  changePasswordFailure,
  changePasswordInCorrectOld,
  changePasswordInCorrectConfirm,
  enterPasswordIsCorrect,
  enterPasswordInCorrect
}

class NotesState extends Equatable {
  const NotesState(
      {this.status = NoteStatus.inital, this.notes, this.isPassword = false});

  final List<Note>? notes;
  final NoteStatus status;
  final bool isPassword;

  @override
  List<Object> get props => [status];

  NotesState copyWith(
      {NoteStatus? status, List<Note>? notes, bool? isPassword}) {
    return NotesState(
        status: status ?? this.status,
        notes: notes ?? this.notes,
        isPassword: isPassword ?? this.isPassword);
  }
}
