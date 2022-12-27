import 'package:note_app/features/note/domain/usecases/change_checkbox_note.dart';
import 'package:note_app/features/note/domain/usecases/change_password_note.dart';
import 'package:note_app/features/note/domain/usecases/change_pin_note.dart';
import 'package:note_app/features/note/domain/usecases/get_password_note.dart';
import 'package:note_app/features/note/domain/usecases/new_password_note.dart';
import 'package:note_app/features/note/presentation/bloc/notes_bloc.dart';

import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/note/data/datasources/note_local_data_sources.dart';
import 'features/note/data/repositories/note_repository_impl.dart';
import 'features/note/domain/repositories/note_repositories.dart';
import 'features/note/domain/usecases/add_note.dart';
import 'features/note/domain/usecases/delete_note.dart';
import 'features/note/domain/usecases/get_all_note.dart';
import 'features/note/domain/usecases/update_note.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - post

  // Bloc

  sl.registerFactory(() => NotesBloc(
      getAllNotesUsecase: sl(),
      deleteNoteUsecase: sl(),
      addNoteUsecase: sl(),
      updateNoteUsecase: sl(),
      changePinNoteUsecase: sl(),
      changeCheckBoxNoteUsecase: sl(),
      getPasswordNoteUsecase: sl(),
      newPasswordNoteUsecase: sl(),
      changePasswordNoteUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => AddNoteUsecase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUsecase(sl()));
  sl.registerLazySingleton(() => GetAllNotesUsecase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUsecase(sl()));
  sl.registerLazySingleton(() => ChangePinNoteUsecase(sl()));
  sl.registerLazySingleton(() => ChangeCheckBoxNoteUsecase(sl()));
  sl.registerLazySingleton(() => GetPasswordNoteUsecase(sl()));
  sl.registerLazySingleton(() => NewPasswordNoteUsecase(sl()));
  sl.registerLazySingleton(() => ChangePasswordNoteUsecase(sl()));

  // Repository
  sl.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(localDateSource: sl()));

  // Datasources
  sl.registerLazySingleton<NoteLocalDateSource>(
      () => NoteLocalDateSourceImpl(sharedPreferences: sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
