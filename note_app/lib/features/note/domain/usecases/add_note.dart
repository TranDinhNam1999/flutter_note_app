import 'package:note_app/features/note/domain/entites/note.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/note_repositories.dart';

class AddNoteUsecase {
  final NotesRepository repository;

  AddNoteUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Note note) async {
    return await repository.addNote(note);
  }
}
