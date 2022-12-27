import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/note_repositories.dart';

class NewPasswordNoteUsecase {
  final NotesRepository repository;

  NewPasswordNoteUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String newPassword) async {
    return await repository.newPasswordNote(newPassword);
  }
}
