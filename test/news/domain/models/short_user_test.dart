import 'package:conecta_gb/news/domain/models/short_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShortUser model test', () {
    test('Correct parse JSON data', () {
      final testData = {
        'name': 'O Boticário',
        'profile_picture':
            'https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png'
      };

      final object = ShortUser.fromMap(testData);

      expect(object.name, 'O Boticário');
      expect(object.picture,
          'https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png');
    });
  });
}
