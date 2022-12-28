import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/note_repositories.dart';

class ChangeIsPasswordNoteUsecase {
  final NotesRepository repository;

  ChangeIsPasswordNoteUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String uuid, int isPasword) async {
    return await repository.changeIsPasswordNote(uuid, isPasword);
  }
}
