import 'dart:math';

import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsRepository extends IPostsRepository {
  final List<Map> _mockedPosts = [];

  final _usersTemplate = [
    {
      'name': 'Ann Tucker',
      'profile_picture': 'https://randomuser.me/api/portraits/women/66.jpg',
    },
    {
      'name': 'Aubrey Bryant',
      'profile_picture': 'https://randomuser.me/api/portraits/women/9.jpg',
    },
    {
      'name': 'Anita Grant',
      'profile_picture': 'https://randomuser.me/api/portraits/women/26.jpg',
    },
    {
      'name': 'Cindy Ramirez',
      'profile_picture': 'https://randomuser.me/api/portraits/women/32.jpg',
    },
    {
      'name': 'Ellen Rodriguez',
      'profile_picture': 'https://randomuser.me/api/portraits/women/67.jpg',
    },
    {
      'name': 'Avery Reynolds',
      'profile_picture': 'https://randomuser.me/api/portraits/women/76.jpg',
    },
    {
      'name': 'Eleanor Walters',
      'profile_picture': 'https://randomuser.me/api/portraits/women/48.jpg',
    },
    {
      'name': 'Jill Daniels',
      'profile_picture': 'https://randomuser.me/api/portraits/women/68.jpg',
    },
    {
      'name': 'Sonia Ford',
      'profile_picture': 'https://randomuser.me/api/portraits/women/37.jpg',
    },
    {
      'name': 'Ellen Rodriguez',
      'profile_picture': 'https://randomuser.me/api/portraits/women/67.jpg',
    }
  ];

  final _postsTemplate = [
    'Ótimo esse novo produto! #amei',
    'Mais um recebido perfeito! #amo',
    'Chegou uma caixa recheada aqui! E já estou fechando outro pedido!! s2',
    'Vocês viram o novo produto? #anciedade',
    'Nossa, meus produtos chegaram em menos de uma semana! #impressionante',
  ];

  PostsRepository() {
    _initializeMockedPosts();
  }

  @override
  Future<Response> getInstitutionalNews() {
    return Dio().get('https://gb-mobile-app-teste.s3.amazonaws.com/data.json');
  }

  void _initializeMockedPosts() {
    for (String element in _postsTemplate) {
      final random = Random().nextInt(_usersTemplate.length);

      _mockedPosts.add({
        'user': _usersTemplate[random],
        'message': {
          'content': element,
          'created_at': DateTime.now().toUtc().toIso8601String()
        },
      });
    }
  }
}
