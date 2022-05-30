import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SendPostObserver extends Observer<void> {
  SendPostObserver(this._presenter);

  final FeedViewPresenter _presenter;

  @override
  void onComplete() {
    assert(_presenter.sendPostOnComplete != null);
    _presenter.sendPostOnComplete?.call();
  }

  @override
  void onError(e) {
    assert(_presenter.sendPostOnError != null);
    _presenter.sendPostOnError?.call(e);
  }

  @override
  void onNext(void response) {}
}
