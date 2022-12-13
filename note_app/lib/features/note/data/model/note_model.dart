import '../../domain/entites/note.dart';

class NoteModel extends Note {
  const NoteModel(
      {required String uuid, required String title, required String body})
      : super(uuid: uuid, body: body, title: title);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        uuid: json["uuid"], title: json["title"], body: json["body"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "title": title,
      "body": body,
    };
  }
}
