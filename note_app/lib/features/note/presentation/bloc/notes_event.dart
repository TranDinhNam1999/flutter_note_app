part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class InitStateEvent extends NotesEvent {}

class GetAllNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final Note note;

  const AddNoteEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends NotesEvent {
  final String uuid;

  const DeleteNoteEvent({required this.uuid});

  @override
  List<Object> get props => [uuid];
}

class UpdateNoteEvent extends NotesEvent {
  final Note note;

  const UpdateNoteEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class ChangePinNodeEvent extends NotesEvent {
  final int isPin;
  final String uuid;

  const ChangePinNodeEvent({required this.isPin, required this.uuid});

  @override
  List<Object> get props => [isPin, uuid];
}

class ChangeCheckboxNodeEvent extends NotesEvent {
  final String uuid;
  final List<CheckListModel> listCheckModel;

  const ChangeCheckboxNodeEvent(
      {required this.uuid, required this.listCheckModel});

  @override
  List<Object> get props => [uuid, listCheckModel];
}

class RefreshPostsEvent extends NotesEvent {}

class NewPasswordNoteEvent extends NotesEvent {
  final String newPassword;
  final String confirmPassword;

  const NewPasswordNoteEvent(
      {required this.newPassword, required this.confirmPassword});

  @override
  List<Object> get props => [newPassword];
}

class ChangePasswordNoteEvent extends NotesEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordNoteEvent(
      {required this.newPassword,
      required this.oldPassword,
      required this.confirmPassword});

  @override
  List<Object> get props => [newPassword, oldPassword, confirmPassword];
}

class GetPasswordNoteEvent extends NotesEvent {
  const GetPasswordNoteEvent();

  @override
  List<Object> get props => [];
}

class ChangeIsPasswordNoteEvent extends NotesEvent {
  const ChangeIsPasswordNoteEvent(
      {required this.isPassword, required this.uuid});
  final int isPassword;
  final String uuid;

  @override
  List<Object> get props => [];
}

class EnterPasswordNoteEvent extends NotesEvent {
  const EnterPasswordNoteEvent({required this.password});
  final String password;

  @override
  List<Object> get props => [password];
}

class CheckIntroEvent extends NotesEvent {
  const CheckIntroEvent();

  @override
  List<Object> get props => [];
}

class AddCheckIntroEvent extends NotesEvent {
  const AddCheckIntroEvent();

  @override
  List<Object> get props => [];
}
