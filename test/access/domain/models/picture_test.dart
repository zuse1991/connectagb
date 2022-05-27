import 'package:conecta_gb/access/domain/entities/picture.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Picture model test', () {
    test('Success full fromMap parse', () {
      final data = {
        'large': 'https://randomuser.me/api/portraits/women/74.jpg',
        'medium': 'https://randomuser.me/api/portraits/med/women/74.jpg',
        'thumbnail': 'https://randomuser.me/api/portraits/thumb/women/74.jpg'
      };
      final picture = Picture.fromMap(data);

      expect(
        picture.large,
        'https://randomuser.me/api/portraits/women/74.jpg',
      );
      expect(
        picture.medium,
        'https://randomuser.me/api/portraits/med/women/74.jpg',
      );
      expect(
        picture.thumbnail,
        'https://randomuser.me/api/portraits/thumb/women/74.jpg',
      );
    });

    test('Success two images fromMap parse', () {
      final data = {
        'medium': 'https://randomuser.me/api/portraits/med/women/74.jpg',
        'thumbnail': 'https://randomuser.me/api/portraits/thumb/women/74.jpg'
      };
      final picture = Picture.fromMap(data);

      expect(
        picture.large,
        null,
      );
      expect(
        picture.medium,
        'https://randomuser.me/api/portraits/med/women/74.jpg',
      );
      expect(
        picture.thumbnail,
        'https://randomuser.me/api/portraits/thumb/women/74.jpg',
      );
    });

    test('Success one image fromMap parse', () {
      final data = {
        'medium': 'https://randomuser.me/api/portraits/med/women/74.jpg',
      };
      final picture = Picture.fromMap(data);

      expect(
        picture.large,
        null,
      );
      expect(
        picture.medium,
        'https://randomuser.me/api/portraits/med/women/74.jpg',
      );
      expect(
        picture.thumbnail,
        null,
      );
    });
  });
}
