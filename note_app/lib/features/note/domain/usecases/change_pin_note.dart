import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/note_repositories.dart';

class ChangePinNoteUsecase {
  final NotesRepository repository;

  ChangePinNoteUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String uuid, int isPin) async {
    return await repository.changePinNote(uuid, isPin);
  }
}
