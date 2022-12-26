import 'package:note_app/features/note/data/model/note_check_list.dart';

import '../../domain/entites/note.dart';

class NoteModel extends Note {
  const NoteModel(
      {required String uuid,
      required String title,
      required String body,
      required int isPin,
      required int indexColor,
      required int indexFont,
      required int colorText,
      required int sizeText,
      required String alignText,
      required int indexImage,
      required List<CheckListModel> listCheck})
      : super(
            uuid: uuid,
            body: body,
            title: title,
            isPin: isPin,
            indexColor: indexColor,
            indexFont: indexFont,
            colorText: colorText,
            sizeText: sizeText,
            alignText: alignText,
            indexImage: indexImage,
            listCheck: listCheck);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      uuid: json["uuid"],
      title: json["title"],
      body: json["body"],
      isPin: json["isPin"],
      indexColor: json["indexColor"],
      indexFont: json["indexFont"],
      colorText: json["colorText"],
      sizeText: json["sizeText"],
      alignText: json["alignText"],
      indexImage: json["indexImage"],
      listCheck: json['listCheck'] != null
          ? (json['listCheck'] as List)
              .map((e) => CheckListModel.fromJson(e))
              .toList()
          : [],
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
      "colorText": colorText,
      "sizeText": sizeText,
      "alignText": alignText,
      "indexImage": indexImage,
      'listCheck':
          listCheck.isNotEmpty ? listCheck.map((e) => e.toJson()).toList() : [],
    };
  }
}
