import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/data/model/note_check_list.dart';
import 'package:note_app/features/note/domain/entites/note.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/note_repositories.dart';
import '../datasources/note_local_data_sources.dart';
import '../model/note_model.dart';

typedef DeleteOrUpdateOrAddNote = Future<Unit> Function();

class NotesRepositoryImpl implements NotesRepository {
  final NoteLocalDateSource localDateSource;

  NotesRepositoryImpl({required this.localDateSource});

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    final localNotes = await localDateSource.getCachedNote();
    return Right(localNotes);
  }

  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    final NoteModel postModel = NoteModel(
        uuid: note.uuid,
        title: note.title,
        body: note.body,
        isPin: note.isPin,
        indexColor: note.indexColor,
        indexFont: note.indexFont,
        colorText: note.colorText,
        sizeText: note.sizeText,
        alignText: note.alignText,
        indexImage: note.indexImage,
        isPassword: note.isPassword,
        listCheck: note.listCheck);

    return await _getMessage(() => localDateSource.addNote(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(String noteUuid) async {
    return await _getMessage(() => localDateSource.deleteNote(noteUuid));
  }

  @override
  Future<Either<Failure, Unit>> updateNote(Note note) async {
    final NoteModel postModel = NoteModel(
        uuid: note.uuid,
        title: note.title,
        body: note.body,
        isPin: note.isPin,
        indexColor: note.indexColor,
        indexFont: note.indexFont,
        colorText: note.colorText,
        sizeText: note.sizeText,
        alignText: note.alignText,
        indexImage: note.indexImage,
        isPassword: note.isPassword,
        listCheck: note.listCheck);

    return await _getMessage(() => localDateSource.updateNote(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddNote deleteOrUpdateOrAddPost) async {
    await deleteOrUpdateOrAddPost();

    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> changeCheckBoxNote(
      String uuid, List<CheckListModel> listCheck) async {
    return await _getMessage(
        () => localDateSource.chnageCheckBoxNote(uuid, listCheck));
  }

  @override
  Future<Either<Failure, Unit>> changePinNote(String uuid, int isPin) async {
    return await _getMessage(() => localDateSource.changePinNote(uuid, isPin));
  }

  @override
  Future<Either<Failure, String>> getPasswordNote() async {
    final localPasswordNotes = await localDateSource.getCachedPassword();
    return Right(localPasswordNotes);
  }

  @override
  Future<Either<Failure, Unit>> newPasswordNote(String newPassword) async {
    return await _getMessage(() => localDateSource.newPassword(newPassword));
  }
}
