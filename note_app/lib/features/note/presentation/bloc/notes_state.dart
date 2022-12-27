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
  changePasswordFailure
}

class NotesState extends Equatable {
  const NotesState({this.status = NoteStatus.inital, this.notes});

  final List<Note>? notes;
  final NoteStatus status;

  @override
  List<Object> get props => [status];

  NotesState copyWith({NoteStatus? status, List<Note>? notes}) {
    return NotesState(
        status: status ?? this.status, notes: notes ?? this.notes);
  }
}
