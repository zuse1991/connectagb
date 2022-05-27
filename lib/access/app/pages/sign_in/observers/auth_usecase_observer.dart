import 'package:conecta_gb/access/app/pages/sign_in/sign_in_presenter.dart';
import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AuthUseCaseObserver extends Observer<User> {
  AuthUseCaseObserver(this._presenter);

  final SignInViewPresenter _presenter;

  @override
  void onComplete() {
    assert(_presenter.onAuthComplete != null);
    _presenter.onAuthComplete?.call();
  }

  @override
  void onError(e) {
    assert(_presenter.onAuthException != null);
    _presenter.onAuthException?.call(e);
  }

  @override
  void onNext(response) {
    assert(_presenter.onAuthData != null);
    _presenter.onAuthData?.call(response as User);
  }
}
