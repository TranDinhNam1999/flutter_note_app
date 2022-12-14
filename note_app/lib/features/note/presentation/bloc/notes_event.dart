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

class RefreshPostsEvent extends NotesEvent {}
