// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../model/note_model.dart';
import 'package:uuid/uuid.dart';

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
  Future<Unit> addNote(NoteModel noteModel) async {
    var localNotes = await getCachedNote();

    if (localNotes.isEmpty) {
      List<NoteModel> list = [];
      list.add(noteModel);
      localNotes = list;
    }

    localNotes.add(noteModel);

    sharedPreferences.setString(CACHED_NOTES, json.encode(localNotes));
    return Future.value(unit);
  }

  @override
  Future<List<NoteModel>> getCachedNote() async {
    var uuid = const Uuid();

    List<NoteModel> list = [
      NoteModel(
          body: "hehehe",
          title: "nam",
          uuid: uuid.v4().toString(),
          isPin: 0,
          indexColor: 3,
          indexFont: 4,
          colorText: "0xff000000"),
      NoteModel(
          body: "hahaha hahah hahah hahah hahah hahah",
          title: 'nhật gà',
          uuid: uuid.v4(),
          isPin: 1,
          indexColor: 2,
          indexFont: 4,
          colorText: "0xff000000"),
      NoteModel(
          body: "hahaha",
          title: 'nhật gà',
          uuid: uuid.v4(),
          isPin: 1,
          indexColor: 5,
          indexFont: 4,
          colorText: "0xff000000"),
      NoteModel(
          body: "hahaha",
          title: 'nhật gà',
          uuid: uuid.v4(),
          isPin: 1,
          indexColor: 7,
          indexFont: 4,
          colorText: "0xff000000")
    ];

    cacheNote(list);

    final jsonString = sharedPreferences.getString(CACHED_NOTES);

    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<NoteModel> jsonToPostModels = decodeJsonData
          .map<NoteModel>((jsonPost) => NoteModel.fromJson(jsonPost))
          .toList();

      return Future.value(jsonToPostModels);
    }
    if (jsonString == null) return Future.value([]);

    return throw EmptyCacheException();
  }
}
