import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String uuid;
  final String title;
  final String body;

  const Note({required this.uuid, required this.title, required this.body});

  @override
  List<Object?> get props => [uuid, title, body];
}
