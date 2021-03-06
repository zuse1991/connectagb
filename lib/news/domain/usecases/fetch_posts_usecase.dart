import 'dart:async';

import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FetchPostsUseCase extends UseCase<List<Post>, void> {
  FetchPostsUseCase(this._postsRepository);
  final IPostsRepository _postsRepository;

  @override
  Future<Stream<List<Post>?>> buildUseCaseStream(void params) async {
    final controller = StreamController<List<Post>>();

    final response = await _postsRepository.fetch();
    final data = (response.data as List)
        .map<Post>((element) => Post.fromMap(element))
        .toList();

    data.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));

    controller.add(data);
    controller.close();

    return controller.stream;
  }
}
