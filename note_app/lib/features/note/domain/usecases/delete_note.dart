import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/note_repositories.dart';

class DeleteNoteUsecase {
  final NotesRepository repository;

  DeleteNoteUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String uuid) async {
    return await repository.deleteNote(uuid);
  }
}
