import 'package:conecta_gb/access/domain/entities/picture.dart';
import 'package:conecta_gb/access/domain/enuns.dart';

class User {
  User._();

  factory User.fromMap(Map data) {
    return User._()
      ..gender = data['gender'] == 'male' ? Gender.male : Gender.female
      ..name = data['name']
      ..email = data['email']
      ..dob = DateTime.parse(data['dob']['date'])
      ..picture = Picture.fromMap(data['picture']);
  }

  late Gender gender;
  late String name;
  late String email;
  late DateTime dob;
  late Picture picture;
}
