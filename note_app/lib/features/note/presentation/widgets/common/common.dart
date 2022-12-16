// ignore: constant_identifier_names
enum TextStyleEnum {
  small('Small'),
  medium('Medium'),
  large('Large'),
  huge('Huge');

  const TextStyleEnum(this.description);
  final String description;

  @override
  String toString() => description;
}
