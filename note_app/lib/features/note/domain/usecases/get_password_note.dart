import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/note_repositories.dart';

class GetPasswordNoteUsecase {
  final NotesRepository repository;
  GetPasswordNoteUsecase(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getPasswordNote();
  }
}
