import 'dart:async';
import 'dart:convert';

import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/access/domain/exceptions/invalid_usecase_parameter_exception.dart';
import 'package:conecta_gb/access/domain/repositories/auth_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class UserAuthUseCase extends UseCase<User, UserAuthParams> {
  UserAuthUseCase(this.authRepository);
  IAuthRepository authRepository;

  @override
  Future<Stream<User?>> buildUseCaseStream(UserAuthParams? params) async {
    StreamController<User> controller = StreamController<User>();

    if (params != null) {
      try {
        final response = authRepository.authenticate(
          email: params.email,
          passwordHash: params.password,
        );
      } on DioError catch (e) {
      } catch (e) {}
    } else {
      controller.addError(InvalidUseCaseParameterException());
    }

    return controller.stream;
  }
}

class UserAuthParams {
  UserAuthParams(this.email, this._password);

  final String email;
  final String _password;

  String get password {
    var bytes = utf8.encode(_password);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }
}
