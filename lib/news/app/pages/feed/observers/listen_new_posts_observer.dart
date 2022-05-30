import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ListenNewPostsObserver extends Observer<Post> {
  ListenNewPostsObserver(this._presenter);

  final FeedViewPresenter _presenter;

  @override
  void onComplete() {
    assert(_presenter.listenNewPostsOnComplete != null);
    _presenter.listenNewPostsOnComplete?.call();
  }

  @override
  void onError(e) {
    assert(_presenter.listenNewPostsOnError != null);
    _presenter.listenNewPostsOnError?.call(e);
  }

  @override
  void onNext(Post? response) {
    assert(_presenter.listenNewPostsOnData != null);
    _presenter.listenNewPostsOnData?.call(response!);
  }
}
