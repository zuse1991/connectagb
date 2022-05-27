import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/access/domain/enuns.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User model test', () {
    test('Success male user fromMap parse', () {
      final testData = {
        'gender': 'male',
        'name': 'Andrei Jiácomo Zuse',
        'email': 'andrei.j.zuse@gmail.com',
        'dob': {'date': '1991-10-20T00:00:00.000Z', 'age': 30},
        'registered': {'date': '2016-02-10T02:36:36.980Z', 'age': 6},
        'picture': {
          'large': 'https://randomuser.me/api/portraits/men/72.jpg',
          'medium': 'https://randomuser.me/api/portraits/med/men/72.jpg',
          'thumbnail': 'https://randomuser.me/api/portraits/thumb/men/72.jpg'
        },
      };

      final user = User.fromMap(testData);

      expect(user.gender, Gender.male);
      expect(user.name, 'Andrei Jiácomo Zuse');
      expect(user.email, 'andrei.j.zuse@gmail.com');
      expect(user.dob, DateTime.utc(1991, 10, 20));
      expect(
        user.picture.large,
        'https://randomuser.me/api/portraits/men/72.jpg',
      );
    });

    test('Success female user fromMap parse', () {
      final testData = {
        'gender': 'female',
        'name': 'Luana Esteves',
        'email': 'luana.esteves@example.com',
        'dob': {'date': '1992-08-02T00:00:00.000Z', 'age': 30},
        'registered': {'date': '2016-02-10T02:36:36.980Z', 'age': 6},
        'picture': {
          'large': 'https://randomuser.me/api/portraits/women/74.jpg',
          'medium': 'https://randomuser.me/api/portraits/med/women/74.jpg',
          'thumbnail': 'https://randomuser.me/api/portraits/thumb/women/74.jpg'
        },
      };

      final user = User.fromMap(testData);

      expect(user.gender, Gender.female);
      expect(user.name, 'Luana Esteves');
      expect(user.email, 'luana.esteves@example.com');
      expect(user.dob, DateTime.utc(1992, 8, 2));
      expect(
        user.picture.medium,
        'https://randomuser.me/api/portraits/med/women/74.jpg',
      );
    });
  });
}
