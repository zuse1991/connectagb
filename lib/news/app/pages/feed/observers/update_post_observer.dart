import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class UpdatePostObserver extends Observer<void> {
  UpdatePostObserver(this._presenter);

  final FeedViewPresenter _presenter;

  @override
  void onComplete() {
    assert(_presenter.updatePostOnComplete != null);
    _presenter.updatePostOnComplete?.call();
  }

  @override
  void onError(e) {
    assert(_presenter.updatePostOnError != null);
    _presenter.updatePostOnError?.call(e);
  }

  @override
  void onNext(void response) {}
}
