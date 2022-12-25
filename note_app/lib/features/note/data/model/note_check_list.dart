import 'package:note_app/features/note/domain/entites/checklist.dart';

class CheckListModel extends CheckList {
  const CheckListModel(
      {required String uuidCheckList,
      required String text,
      required int isCheck})
      : super(uuidCheckList: uuidCheckList, text: text, isCheck: isCheck);

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
      uuidCheckList: json["uuidCheckList"],
      text: json["text"],
      isCheck: json["isCheck"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uuidCheckList": uuidCheckList,
      "text": text,
      "isCheck": isCheck,
    };
  }
}
