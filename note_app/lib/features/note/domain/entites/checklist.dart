import 'package:equatable/equatable.dart';

class CheckList extends Equatable {
  final String uuidCheckList;
  final String text;
  final int isCheck;

  const CheckList(
      {required this.uuidCheckList, required this.text, required this.isCheck});

  @override
  List<Object?> get props => [uuidCheckList, text, isCheck];

  static fromJson(e) {}
}
