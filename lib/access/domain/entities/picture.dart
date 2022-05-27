class Picture {
  Picture._();

  factory Picture.fromMap(Map data) {
    return Picture._()
      ..large = data['large']
      ..medium = data['medium']
      ..thumbnail = data['thumbnail'];
  }

  String? large;
  String? medium;
  String? thumbnail;
}
