import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/note_repositories.dart';

class GetCheckIntroUsecase {
  final NotesRepository repository;
  GetCheckIntroUsecase(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getCheckIntro();
  }
}
