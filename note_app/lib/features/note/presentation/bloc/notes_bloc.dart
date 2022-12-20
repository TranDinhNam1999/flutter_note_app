import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/domain/usecases/add_note.dart';
import 'package:note_app/features/note/domain/usecases/delete_note.dart';

import '../../domain/entites/note.dart';
import '../../domain/usecases/get_all_note.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUsecase getAllNotesUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;
  final AddNoteUsecase addNoteUsecase;

  NotesBloc(
      {required this.getAllNotesUsecase,
      required this.deleteNoteUsecase,
      required this.addNoteUsecase})
      : super(const NotesState()) {
    on<InitStateEvent>(_onInitStateEvent);
    on<GetAllNotesEvent>(_onGetAllNotesEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
    on<AddNoteEvent>(_onAddNoteEvent);
  }

  Future<void> _onInitStateEvent(
      InitStateEvent event, Emitter<NotesState> emit) async {
    try {
      var data = await getAllNotesUsecase();

      emit(state.copyWith(
          status: NoteStatus.inital,
          notes: data.fold(((l) => null), (r) => r)));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, notes: null));
    }
  }

  Future<void> _onGetAllNotesEvent(
      GetAllNotesEvent event, Emitter<NotesState> emit) async {
    try {
      var data = await getAllNotesUsecase();

      emit(state.copyWith(
          status: NoteStatus.success,
          notes: data.fold(((l) => null), (r) => r)));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, notes: null));
    }
  }

  Future<void> _onDeleteNoteEvent(
      DeleteNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading, notes: state.notes));

    try {
      await deleteNoteUsecase(event.uuid);

      var data = await getAllNotesUsecase();
      emit(state.copyWith(
          status: NoteStatus.deleteSuccess,
          notes: data.fold(((l) => null), (r) => r)));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, notes: null));
    }
  }

  Future<void> _onAddNoteEvent(
      AddNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading, notes: state.notes));

    try {
      await addNoteUsecase(event.note);

      var data = await getAllNotesUsecase();
      emit(state.copyWith(
          status: NoteStatus.addSuccess,
          notes: data.fold(((l) => null), (r) => r)));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.failure, notes: null));
    }
  }
}
