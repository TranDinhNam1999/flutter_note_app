// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../model/note_model.dart';

const CACHED_NOTES = "CACHED_NOTES";

abstract class NoteLocalDateSource {
  Future<List<NoteModel>> getCachedNote();

  Future<Unit> cacheNote(List<NoteModel> postModel);
  Future<Unit> deleteNote(String noteUuid);
  Future<Unit> updateNote(NoteModel postModel);
  Future<Unit> addNote(NoteModel postModel);
}

class NoteLocalDateSourceImpl implements NoteLocalDateSource {
  final SharedPreferences sharedPreferences;

  NoteLocalDateSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheNote(List<NoteModel> noteModel) {
    List noteModelToJson = noteModel.map((note) => note.toJson()).toList();

    sharedPreferences.setString(CACHED_NOTES, json.encode(noteModelToJson));

    return Future.value(unit);
  }

  @override
  Future<Unit> deleteNote(String noteUuid) async {
    final localPosts = await getCachedNote();

    localPosts.removeWhere((element) => element.uuid == noteUuid);

    sharedPreferences.setString(CACHED_NOTES, json.encode(localPosts));
    return Future.value(unit);
  }

  @override
  Future<Unit> updateNote(NoteModel postModel) async {
    final localPosts = await getCachedNote();

    localPosts.removeWhere((element) => element.uuid == postModel.uuid);
    localPosts.add(postModel);

    sharedPreferences.setString(CACHED_NOTES, json.encode(localPosts));
    return Future.value(unit);
  }

  @override
  Future<Unit> addNote(NoteModel postModel) async {
    final localPosts = await getCachedNote();

    localPosts.add(postModel);

    sharedPreferences.setString(CACHED_NOTES, json.encode(localPosts));
    return Future.value(unit);
  }

  @override
  Future<List<NoteModel>> getCachedNote() {
    final jsonString = sharedPreferences.getString(CACHED_NOTES);

    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<NoteModel> jsonToPostModels = decodeJsonData
          .map<NoteModel>((jsonPost) => NoteModel.fromJson(jsonPost))
          .toList();

      return Future.value(jsonToPostModels);
    }

    return throw EmptyCacheException();
  }
}
