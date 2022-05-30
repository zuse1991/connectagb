import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/news/app/pages/feed/observers/fetch_posts_observer.dart';
import 'package:conecta_gb/news/app/pages/feed/observers/institutional_news_observer.dart';
import 'package:conecta_gb/news/app/pages/feed/observers/listen_new_posts_observer.dart';
import 'package:conecta_gb/news/app/pages/feed/observers/send_post_observer.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:conecta_gb/news/domain/usecases/fetch_posts_usecase.dart';
import 'package:conecta_gb/news/domain/usecases/get_institutional_news_usecase.dart';
import 'package:conecta_gb/news/domain/usecases/listen_new_posts_usecase.dart';
import 'package:conecta_gb/news/domain/usecases/send_post_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FeedViewPresenter extends Presenter {
  FeedViewPresenter(IPostsRepository postsRepository)
      : _institutionalNewsUseCase =
            GetInstitutionalNewsUseCase(postsRepository),
        _fetchPostsUseCase = FetchPostsUseCase(postsRepository),
        _sendPostUseCase = SendPostUseCase(postsRepository),
        _listenNewPostsUseCase = ListenNewPostsUseCase(postsRepository);

  final GetInstitutionalNewsUseCase _institutionalNewsUseCase;
  final FetchPostsUseCase _fetchPostsUseCase;
  final SendPostUseCase _sendPostUseCase;
  final ListenNewPostsUseCase _listenNewPostsUseCase;

  Function()? institutionalNewsOnComplete;
  void Function(List<Post>)? institutionalNewsOnData;
  void Function(dynamic)? institutionalNewsOnError;

  Function()? fetchPostsOnComplete;
  void Function(List<Post>)? fetchPostsOnData;
  void Function(dynamic)? fetchPostsOnError;

  Function()? sendPostOnComplete;
  void Function(List<Post>)? sendPostOnData;
  void Function(dynamic)? sendPostOnError;

  Function()? listenNewPostsOnComplete;
  void Function(Post)? listenNewPostsOnData;
  void Function(dynamic)? listenNewPostsOnError;

  void fetchPosts() {
    _fetchPostsUseCase.execute(FetchPostsObserver(this));
  }

  void fetchInstitutionalNews() {
    _institutionalNewsUseCase.execute(InstitutionalNewsObserver(this));
  }

  void sendPost(User user, String message) {
    _sendPostUseCase.execute(
      SendPostObserver(this),
      SendPostParam(user: user, message: message),
    );
  }

  void listenNewPosts() {
    _listenNewPostsUseCase.execute(ListenNewPostsObserver(this));
  }

  @override
  void dispose() {
    _institutionalNewsUseCase.dispose();
    _fetchPostsUseCase.dispose();
    _sendPostUseCase.dispose();
    _listenNewPostsUseCase.dispose();
  }
}
