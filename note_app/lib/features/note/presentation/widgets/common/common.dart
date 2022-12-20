import 'package:flutter/material.dart';

enum TextStyleEnum {
  small('Small', 18),
  medium('Medium', 24),
  large('Large', 30),
  huge('Huge', 38);

  const TextStyleEnum(this.description, this.sizetext);
  final String description;
  final double sizetext;

  @override
  String toString() => description;
}

enum IconAlignEnum {
  left('Left', TextAlign.left),
  center('Center', TextAlign.center),
  right('Right', TextAlign.right);

  const IconAlignEnum(this.description, this.textAlign);
  final String description;
  final TextAlign textAlign;

  @override
  String toString() => description;
}
