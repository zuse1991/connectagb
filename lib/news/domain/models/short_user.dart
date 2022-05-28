class ShortUser {
  ShortUser._();

  factory ShortUser.fromMap(Map data) => ShortUser._()
    ..name = data['name']
    ..picture = data['profile_picture'];

  late String name;
  late String picture;
}
