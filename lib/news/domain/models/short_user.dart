class ShortUser {
  ShortUser._();

  factory ShortUser.fromMap(Map data) => ShortUser._()
    ..name = data['name']
    ..picture = data['profile_picture']
    ..email = data['email'];

  late String name;
  late String picture;
  String? email;
}
