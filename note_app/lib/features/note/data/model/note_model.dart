import '../../domain/entites/note.dart';

class NoteModel extends Note {
  const NoteModel(
      {required String uuid,
      required String title,
      required String body,
      required int isPin,
      required int indexColor,
      required int indexFont,
      required String colorText})
      : super(
            uuid: uuid,
            body: body,
            title: title,
            isPin: isPin,
            indexColor: indexColor,
            indexFont: indexColor,
            colorText: colorText);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      uuid: json["uuid"],
      title: json["title"],
      body: json["body"],
      isPin: json["isPin"],
      indexColor: json["indexColor"],
      indexFont: json["indexFont"],
      colorText: json["colorText"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "title": title,
      "body": body,
      "isPin": isPin,
      "indexColor": indexColor,
      "indexFont": indexFont,
      "colorText": colorText
    };
  }
}
