import 'package:dartz/dartz.dart';
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
        alignText: note.alignText);

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
        alignText: note.alignText);

    return await _getMessage(() => localDateSource.updateNote(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddNote deleteOrUpdateOrAddPost) async {
    await deleteOrUpdateOrAddPost();

    return const Right(unit);
  }
}
