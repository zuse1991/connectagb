import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/access/domain/exceptions/invalid_sign_in_data_exception.dart';
import 'package:conecta_gb/access/domain/repositories/auth_repository.dart';
import 'package:conecta_gb/access/domain/usecases/user_auth_usecase.dart';
import 'package:conecta_gb/commom/exceptions/missing_usecase_parameter_exception.dart';
import 'package:conecta_gb/commom/exceptions/unrecognized_network_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/default_test_observer.dart';
import '../../data/repository/auth_repository_mock.dart';

void main() {
  group('UserAuthParams test', () {
    test('Email are present and password are encrypted as expected', () {
      final param = UserAuthParams('email@example.com', 'grupoboticario');
      expect(param.email, 'email@example.com');
      expect(param.password, '003670073a9089519ebbfc4143d00821');
    });
  });

  group('UserAuthUseCase test', () {
    late IAuthRepository repository;
    late UserAuthUseCase useCase;
    late DefaultTestObserver<User> observer;

    setUp(() {
      repository = AuthRepositoryMock();
      useCase = UserAuthUseCase(repository);
      observer = DefaultTestObserver();
    });

    test('Success execute and return user', () async {
      final param = UserAuthParams('email@example.com', 'grupoboticario');
      useCase.execute(observer, param);

      while (!observer.ended) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 5));
      }

      expect(observer.done, true);
      expect(observer.data, const TypeMatcher<User>());
      expect(observer.error, false);
    });

    test('Missing UseCase param exception are throwed', () async {
      useCase.execute(observer);

      while (!observer.ended) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 5));
      }

      expect(observer.done, false);
      expect(observer.error, true);
      expect(
        observer.exception,
        const TypeMatcher<MissingUseCaseParameterException>(),
      );
    });

    test('Exception InvalidSignInDataException are throwed', () async {
      final param = UserAuthParams('email@example.com', 'wrong');
      useCase.execute(observer, param);

      while (!observer.ended) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 5));
      }

      expect(observer.done, false);
      expect(observer.error, true);
      expect(
        observer.exception,
        const TypeMatcher<InvalidSignInDataException>(),
      );
    });

    test('Exception UnrecognizedNetworkException are throwed', () async {
      final param = UserAuthParams('email@example.com', 'other');
      useCase.execute(observer, param);

      while (!observer.ended) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 5));
      }

      expect(observer.done, false);
      expect(observer.error, true);
      expect(
        observer.exception,
        const TypeMatcher<UnrecognizedNetworkException>(),
      );
    });
  });
}
