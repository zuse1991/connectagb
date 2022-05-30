import 'dart:async';

import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ListenNewPostsUseCase extends UseCase<Post, void> {
  ListenNewPostsUseCase(this._postsRepository);

  final IPostsRepository _postsRepository;
  StreamSubscription? _subscription;

  @override
  Future<Stream<Post?>> buildUseCaseStream(void params) async {
    StreamController<Post> controller = StreamController<Post>();

    _subscription = (await _postsRepository.listenNewPosts()).listen((event) {
      controller.add(Post.fromMap(event));
    });

    return controller.stream;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
