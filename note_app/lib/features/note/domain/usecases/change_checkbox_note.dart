import 'package:note_app/features/note/data/model/note_check_list.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/note_repositories.dart';

class ChangeCheckBoxNoteUsecase {
  final NotesRepository repository;

  ChangeCheckBoxNoteUsecase(this.repository);

  Future<Either<Failure, Unit>> call(
      String uuid, List<CheckListModel> listCheck) async {
    return await repository.changeCheckBoxNote(uuid, listCheck);
  }
}
