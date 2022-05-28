import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsRepository extends IPostsRepository {
  final _postsStreamController = StreamController<Map>();
  Timer? _postsTimer;
  final List<Map> _mockedPosts = [];

  final _usersTemplate = [
    {
      'name': 'Ann Tucker',
      'profile_picture': 'https://randomuser.me/api/portraits/women/66.jpg',
      'email': 'ann.tucker@email.com'
    },
    {
      'name': 'Aubrey Bryant',
      'profile_picture': 'https://randomuser.me/api/portraits/women/9.jpg',
      'email': 'aubrey.bryant@email.com'
    },
    {
      'name': 'Anita Grant',
      'profile_picture': 'https://randomuser.me/api/portraits/women/26.jpg',
      'email': 'anita.grant@email.com'
    },
    {
      'name': 'Cindy Ramirez',
      'profile_picture': 'https://randomuser.me/api/portraits/women/32.jpg',
      'email': 'cindy.ramirez@email.com'
    },
    {
      'name': 'Ellen Rodriguez',
      'profile_picture': 'https://randomuser.me/api/portraits/women/67.jpg',
      'email': 'ellen.rodriguez@email.com'
    },
    {
      'name': 'Avery Reynolds',
      'profile_picture': 'https://randomuser.me/api/portraits/women/76.jpg',
      'email': 'avery.reynolds@email.com'
    },
    {
      'name': 'Eleanor Walters',
      'profile_picture': 'https://randomuser.me/api/portraits/women/48.jpg',
      'email': 'eleanor.walters@email.com'
    },
    {
      'name': 'Jill Daniels',
      'profile_picture': 'https://randomuser.me/api/portraits/women/68.jpg',
      'email': 'jill.daniels@email.com'
    },
    {
      'name': 'Sonia Ford',
      'profile_picture': 'https://randomuser.me/api/portraits/women/37.jpg',
      'email': 'sonia.ford@email.com'
    },
    {
      'name': 'Ellen Rodriguez',
      'profile_picture': 'https://randomuser.me/api/portraits/women/67.jpg',
      'email': 'ellen.rodriguez@email.com'
    }
  ];

  final _postsTemplate = [
    'Ótimo esse novo produto! #amei',
    'Mais um recebido perfeito! #amo',
    'Chegou uma caixa recheada aqui! E já estou fechando outro pedido!! s2',
    'Vocês viram o novo produto? Super aguardando mais detalhes sobre! #anciedade',
    'Nossa, meus produtos chegaram em menos de uma semana! #impressionante',
  ];

  @override
  Future<Response> getInstitutionalNews() {
    return Dio().get('https://gb-mobile-app-teste.s3.amazonaws.com/data.json');
  }

  @override
  Future<Response> create(Map post) async {
    post['message']['created_at'] = DateTime.now().toUtc().toIso8601String();

    _addToMock(post);

    return Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 201,
      data: _mockedPosts.last,
    );
  }

  @override
  Future<Response> fetch() async {
    if (_mockedPosts.isEmpty) {
      _initializeMockedPosts();
    }

    return Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
      data: _mockedPosts,
    );
  }

  @override
  Future<Stream<Map>> listenNewPosts() async {
    return _postsStreamController.stream;
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

    _postsTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        final postPosition = Random().nextInt(_postsTemplate.length);
        final userPosition = Random().nextInt(_usersTemplate.length);

        _addToMock({
          'user': _usersTemplate[userPosition],
          'message': {
            'content': _postsTemplate[postPosition],
            'created_at': DateTime.now().toUtc().toIso8601String()
          },
        });
      },
    );
  }

  void _addToMock(Map data) {
    _mockedPosts.add(data);
    _postsStreamController.add(data);
  }

  @override
  void dispose() {
    _postsTimer?.cancel();
    _postsStreamController.close();
  }
}
