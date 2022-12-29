import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/data/model/note_check_list.dart';
import 'package:note_app/features/note/domain/usecases/add_note.dart';
import 'package:note_app/features/note/domain/usecases/change_checkbox_note.dart';
import 'package:note_app/features/note/domain/usecases/change_password_note.dart';
import 'package:note_app/features/note/domain/usecases/change_pin_note.dart';
import 'package:note_app/features/note/domain/usecases/delete_note.dart';
import 'package:note_app/features/note/domain/usecases/get_password_note.dart';
import 'package:note_app/features/note/domain/usecases/new_password_note.dart';
import 'package:note_app/features/note/domain/usecases/update_note.dart';

import '../../domain/entites/note.dart';
import '../../domain/usecases/change_is_password_note.dart';
import '../../domain/usecases/get_all_note.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUsecase getAllNotesUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;
  final AddNoteUsecase addNoteUsecase;
  final UpdateNoteUsecase updateNoteUsecase;
  final ChangePinNoteUsecase changePinNoteUsecase;
  final ChangeCheckBoxNoteUsecase changeCheckBoxNoteUsecase;
  final GetPasswordNoteUsecase getPasswordNoteUsecase;
  final NewPasswordNoteUsecase newPasswordNoteUsecase;
  final ChangePasswordNoteUsecase changePasswordNoteUsecase;
  final ChangeIsPasswordNoteUsecase changeIsPasswordNoteUsecase;

  NotesBloc(
      {required this.getAllNotesUsecase,
      required this.deleteNoteUsecase,
      required this.addNoteUsecase,
      required this.updateNoteUsecase,
      required this.changePinNoteUsecase,
      required this.changeCheckBoxNoteUsecase,
      required this.getPasswordNoteUsecase,
      required this.newPasswordNoteUsecase,
      required this.changePasswordNoteUsecase,
      required this.changeIsPasswordNoteUsecase})
      : super(const NotesState()) {
    on<InitStateEvent>(_onInitStateEvent);
    on<GetAllNotesEvent>(_onGetAllNotesEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
    on<AddNoteEvent>(_onAddNoteEvent);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    on<ChangePinNodeEvent>(_onChangePinNodeEvent);
    on<ChangeCheckboxNodeEvent>(_onChangeCheckboxNodeEvent);
    on<NewPasswordNoteEvent>(_onNewPasswordNoteEvent);
    on<ChangePasswordNoteEvent>(_onChangePasswordNoteEvent);
    on<ChangeIsPasswordNoteEvent>(_onChangeIsPasswordNoteEvent);
    on<EnterPasswordNoteEvent>(_onEnterPasswordNoteEvent);
  }

  Future<void> _onInitStateEvent(
      InitStateEvent event, Emitter<NotesState> emit) async {
    try {
      var data = await getAllNotesUsecase();
      var checkPassword = await getPasswordNoteUsecase();
      var isPassword = checkPassword.fold(((l) => null), (r) => r);
      emit(state.copyWith(
          status: NoteStatus.inital,
          notes: data.fold(((l) => null), (r) => r),
          isPassword: isPassword != "" ? true : false));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onGetAllNotesEvent(
      GetAllNotesEvent event, Emitter<NotesState> emit) async {
    try {
      var data = await getAllNotesUsecase();
      var checkPassword = await getPasswordNoteUsecase();
      var isPassword = checkPassword.fold(((l) => null), (r) => r);

      emit(state.copyWith(
          status: NoteStatus.success,
          notes: data.fold(((l) => null), (r) => r),
          isPassword: isPassword != "" ? true : false));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onDeleteNoteEvent(
      DeleteNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      await deleteNoteUsecase(event.uuid);

      var data = await getAllNotesUsecase();
      emit(state.copyWith(
          status: NoteStatus.deleteSuccess,
          notes: data.fold(((l) => null), (r) => r)));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onAddNoteEvent(
      AddNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      await addNoteUsecase(event.note);

      var data = await getAllNotesUsecase();
      emit(state.copyWith(
          status: NoteStatus.addSuccess,
          notes: data.fold(((l) => null), (r) => r)));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onUpdateNoteEvent(
      UpdateNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      await updateNoteUsecase(event.note);

      var data = await getAllNotesUsecase();
      emit(state.copyWith(
          status: NoteStatus.updateSuccess,
          notes: data.fold(((l) => null), (r) => r),
          isPassword: state.isPassword));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onChangePinNodeEvent(
      ChangePinNodeEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      await changePinNoteUsecase(event.uuid, event.isPin);

      var data = await getAllNotesUsecase();
      emit(state.copyWith(
          status: NoteStatus.updateSuccess,
          notes: data.fold(((l) => null), (r) => r)));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onChangeCheckboxNodeEvent(
      ChangeCheckboxNodeEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      await changeCheckBoxNoteUsecase(event.uuid, event.listCheckModel);
      var data = await getAllNotesUsecase();
      emit(state.copyWith(
          status: NoteStatus.updateSuccess,
          notes: data.fold(((l) => null), (r) => r),
          isPassword: state.isPassword));
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onNewPasswordNoteEvent(
      NewPasswordNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      if (event.newPassword == "") {
        emit(state.copyWith(
            status: NoteStatus.changePasswordIsNotNullorEmpty,
            notes: state.notes,
            isPassword: state.isPassword));
      } else if (event.newPassword != event.confirmPassword) {
        emit(state.copyWith(
            status: NoteStatus.changePasswordFailure,
            notes: state.notes,
            isPassword: state.isPassword));
      } else {
        await newPasswordNoteUsecase(event.newPassword);

        emit(state.copyWith(
            status: NoteStatus.changePasswordSuccess,
            notes: state.notes,
            isPassword: true));
      }
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.changePasswordFailure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onChangePasswordNoteEvent(
      ChangePasswordNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      var checkPassword = await getPasswordNoteUsecase();
      var oldPassword = checkPassword.fold(((l) => null), (r) => r);

      if (event.newPassword == "") {
        emit(state.copyWith(
            status: NoteStatus.changePasswordIsNotNullorEmpty,
            notes: state.notes,
            isPassword: state.isPassword));
      } else if (event.oldPassword != oldPassword) {
        emit(state.copyWith(
            status: NoteStatus.changePasswordInCorrectOld,
            notes: state.notes,
            isPassword: state.isPassword));
      } else if (event.newPassword != event.confirmPassword) {
        emit(state.copyWith(
            status: NoteStatus.changePasswordInCorrectConfirm,
            notes: state.notes,
            isPassword: state.isPassword));
      } else {
        await newPasswordNoteUsecase(event.newPassword);

        emit(state.copyWith(
            status: NoteStatus.changePasswordSuccess,
            notes: state.notes,
            isPassword: true));
      }
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.changePasswordFailure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onChangeIsPasswordNoteEvent(
      ChangeIsPasswordNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      var checkPassword = await getPasswordNoteUsecase();
      var isPassword = checkPassword.fold(((l) => null), (r) => r);

      if (isPassword == "") {
        emit(state.copyWith(
            status: NoteStatus.passwordIsNoTConfigured, notes: state.notes));
      } else {
        await changeIsPasswordNoteUsecase(event.uuid, event.isPassword);

        var data = await getAllNotesUsecase();
        emit(state.copyWith(
            status: NoteStatus.updateSuccess,
            notes: data.fold(((l) => null), (r) => r)));
      }
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.failure,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }

  Future<void> _onEnterPasswordNoteEvent(
      EnterPasswordNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(
        status: NoteStatus.loading,
        notes: state.notes,
        isPassword: state.isPassword));

    try {
      var checkPassword = await getPasswordNoteUsecase();
      var oldPassword = checkPassword.fold(((l) => null), (r) => r);

      if (event.password == oldPassword) {
        emit(state.copyWith(
            status: NoteStatus.enterPasswordIsCorrect, notes: state.notes));
      } else {
        emit(state.copyWith(
            status: NoteStatus.enterPasswordInCorrect, notes: state.notes));
      }
    } catch (e) {
      emit(state.copyWith(
          status: NoteStatus.enterPasswordInCorrect,
          notes: state.notes,
          isPassword: state.isPassword));
    }
  }
}
