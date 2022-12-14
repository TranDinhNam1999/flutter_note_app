import '../../domain/entites/note.dart';

class NoteModel extends Note {
  const NoteModel(
      {required String uuid,
      required String title,
      required String body,
      required int isPin,
      required int indexColor})
      : super(
            uuid: uuid,
            body: body,
            title: title,
            isPin: isPin,
            indexColor: indexColor);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        uuid: json["uuid"],
        title: json["title"],
        body: json["body"],
        isPin: json["isPin"],
        indexColor: json["indexColor"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "title": title,
      "body": body,
      "isPin": isPin,
      "indexColor": indexColor
    };
  }
}
