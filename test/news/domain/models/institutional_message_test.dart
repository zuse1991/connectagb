import 'package:conecta_gb/news/domain/models/institutional_message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InstitutionalMessage model test', () {
    test('Correct parse JSON data ', () {
      final testData = {
        'user': {
          'name': 'O Boticário',
          'profile_picture':
              'https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png'
        },
        'message': {
          'content':
              'Com a união das demais marcas do grupo, doamos 216 toneladas de produtos de higiene para comunidades em vulnerabilidade social de diversas partes do país.',
          'created_at': '2020-02-02T15:10:33Z'
        }
      };

      final object = InstitutionalMessage.fromMap(testData);

      expect(object.user.name, 'O Boticário');
      expect(object.content,
          'Com a união das demais marcas do grupo, doamos 216 toneladas de produtos de higiene para comunidades em vulnerabilidade social de diversas partes do país.');
      expect(object.createdAt, DateTime(2020, 2, 2, 12, 10, 33));
    });
  });
}
