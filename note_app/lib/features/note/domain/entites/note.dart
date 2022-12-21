import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String uuid;
  final String title;
  final String body;
  final int isPin;
  final int indexColor;
  final int indexFont;
  final int colorText;
  final int sizeText;
  final String alignText;

  const Note(
      {required this.uuid,
      required this.title,
      required this.body,
      required this.isPin,
      required this.indexColor,
      required this.indexFont,
      required this.colorText,
      required this.sizeText,
      required this.alignText});

  @override
  List<Object?> get props => [
        uuid,
        title,
        body,
        isPin,
        indexColor,
        indexFont,
        colorText,
        sizeText,
        alignText
      ];
}
