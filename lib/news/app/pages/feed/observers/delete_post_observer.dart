import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeletePostObserver extends Observer<void> {
  DeletePostObserver(this._presenter);

  final FeedViewPresenter _presenter;

  @override
  void onComplete() {
    assert(_presenter.deletePostOnComplete != null);
    _presenter.deletePostOnComplete?.call();
  }

  @override
  void onError(e) {
    assert(_presenter.deletePostOnError != null);
    _presenter.deletePostOnError?.call(e);
  }

  @override
  void onNext(void response) {}
}
