import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FetchPostsObserver extends Observer<List<Post>> {
  FetchPostsObserver(this._presenter);

  final FeedViewPresenter _presenter;

  @override
  void onComplete() {
    assert(_presenter.fetchPostsOnComplete != null);
    _presenter.fetchPostsOnComplete?.call();
  }

  @override
  void onError(e) {
    assert(_presenter.fetchPostsOnError != null);
    _presenter.fetchPostsOnError?.call(e);
  }

  @override
  void onNext(List<Post>? response) {
    assert(_presenter.fetchPostsOnData != null);
    _presenter.fetchPostsOnData?.call(response!);
  }
}
