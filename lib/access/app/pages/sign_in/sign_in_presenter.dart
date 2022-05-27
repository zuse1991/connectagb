import 'package:conecta_gb/access/app/pages/sign_in/observers/auth_usecase_observer.dart';
import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/access/domain/repositories/auth_repository.dart';
import 'package:conecta_gb/access/domain/usecases/user_auth_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SignInViewPresenter extends Presenter {
  SignInViewPresenter({required IAuthRepository authRepository})
      : _authUseCase = UserAuthUseCase(authRepository);

  final UserAuthUseCase _authUseCase;

  Function()? onAuthComplete;
  void Function(User)? onAuthData;
  void Function(dynamic)? onAuthException;

  void authenticate(String email, String password) {
    _authUseCase.execute(
      AuthUseCaseObserver(this),
      UserAuthParams(email, password),
    );
  }

  @override
  void dispose() {
    _authUseCase.dispose();
  }
}
