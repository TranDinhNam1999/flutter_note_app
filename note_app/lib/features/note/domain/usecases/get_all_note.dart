import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/entites/note.dart';

import '../../../../core/error/failure.dart';
import '../repositories/note_repositories.dart';

class GetAllNotesUsecase {
  final NotesRepository repository;
  GetAllNotesUsecase(this.repository);

  Future<Either<Failure, List<Note>>> call() async {
    return await repository.getAllNotes();
  }
}
