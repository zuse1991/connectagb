import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:conecta_gb/news/domain/models/post.dart';

class InstitutionalNewsObserver extends Observer<List<Post>> {
  InstitutionalNewsObserver(this._presenter);

  final FeedViewPresenter _presenter;

  @override
  void onComplete() {
    assert(_presenter.institutionalNewsOnComplete != null);
    _presenter.institutionalNewsOnComplete?.call();
  }

  @override
  void onError(e) {
    assert(_presenter.institutionalNewsOnError != null);
    _presenter.institutionalNewsOnError?.call(e);
  }

  @override
  void onNext(List<Post>? response) {
    assert(_presenter.institutionalNewsOnData != null);
    _presenter.institutionalNewsOnData?.call(response!);
  }
}
