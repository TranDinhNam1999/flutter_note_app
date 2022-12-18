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
