import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/entites/note.dart';

import '../../../../core/error/failure.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> getAllNotes();

  Future<Either<Failure, Unit>> deleteNote(String uuid);

  Future<Either<Failure, Unit>> updateNote(Note note);

  Future<Either<Failure, Unit>> addNote(Note note);
}
