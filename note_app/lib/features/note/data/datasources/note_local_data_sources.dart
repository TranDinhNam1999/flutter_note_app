// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/data/model/note_check_list.dart';
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
  Future<Unit> changePinNote(String uuidCheck, int isCheck);
  Future<Unit> chnageCheckBoxNote(String uuid, List<CheckListModel> listCheck);
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
    } else {
      localNotes.add(noteModel);
    }

    sharedPreferences.setString(CACHED_NOTES, json.encode(localNotes));
    return Future.value(unit);
  }

  @override
  Future<List<NoteModel>> getCachedNote() async {
    final jsonString = sharedPreferences.getString(CACHED_NOTES);

    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<NoteModel> jsonToPostModels = decodeJsonData
          .map<NoteModel>((jsonPost) => NoteModel.fromJson(jsonPost))
          .toList();

      jsonToPostModels.sort(((a, b) => b.isPin.compareTo(a.isPin)));

      return Future.value(jsonToPostModels);
    }
    if (jsonString == null) return Future.value([]);

    return throw EmptyCacheException();
  }

  @override
  Future<Unit> changePinNote(String uuid, int isPin) async {
    final localPosts = await getCachedNote();

    var noteChange = localPosts.where((element) => element.uuid == uuid).first;

    final NoteModel notechangeModel = NoteModel(
        uuid: noteChange.uuid,
        title: noteChange.title,
        body: noteChange.body,
        isPin: isPin,
        indexColor: noteChange.indexColor,
        indexFont: noteChange.indexFont,
        colorText: noteChange.colorText,
        sizeText: noteChange.sizeText,
        alignText: noteChange.alignText,
        indexImage: noteChange.indexImage,
        listCheck: noteChange.listCheck);

    localPosts.removeWhere((element) => element.uuid == uuid);
    localPosts.add(notechangeModel);

    sharedPreferences.setString(CACHED_NOTES, json.encode(localPosts));
    return Future.value(unit);
  }

  @override
  Future<Unit> chnageCheckBoxNote(
      String uuid, List<CheckListModel> listCheck) async {
    final localPosts = await getCachedNote();

    var noteChange = localPosts.where((element) => element.uuid == uuid).first;

    final NoteModel notechangeModel = NoteModel(
        uuid: noteChange.uuid,
        title: noteChange.title,
        body: noteChange.body,
        isPin: noteChange.isPin,
        indexColor: noteChange.indexColor,
        indexFont: noteChange.indexFont,
        colorText: noteChange.colorText,
        sizeText: noteChange.sizeText,
        alignText: noteChange.alignText,
        indexImage: noteChange.indexImage,
        listCheck: listCheck);

    localPosts.removeWhere((element) => element.uuid == uuid);
    localPosts.add(notechangeModel);

    sharedPreferences.setString(CACHED_NOTES, json.encode(localPosts));
    return Future.value(unit);
  }
}
