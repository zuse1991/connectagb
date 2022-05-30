import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:conecta_gb/news/domain/models/institutional_message.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class InstitutionalNewsObserver extends Observer<List<InstitutionalMessage>> {
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
  void onNext(List<InstitutionalMessage>? response) {
    assert(_presenter.institutionalNewsOnData != null);
    _presenter.institutionalNewsOnData?.call(response!);
  }
}
