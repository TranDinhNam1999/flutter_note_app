import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/note_repositories.dart';

class AddCheckIntroUsecase {
  final NotesRepository repository;

  AddCheckIntroUsecase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.addCheckIntro();
  }
}
