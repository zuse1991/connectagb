import 'dart:async';
import 'dart:convert';

import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/access/domain/exceptions/invalid_sign_in_data_exception.dart';
import 'package:conecta_gb/access/domain/repositories/auth_repository.dart';
import 'package:conecta_gb/commom/exceptions/missing_usecase_parameter_exception.dart';
import 'package:conecta_gb/commom/exceptions/unrecognized_network_exception.dart';
import 'package:conecta_gb/commom/exceptions/unrecognized_usecase_exception.dart';
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
        final response = await authRepository.authenticate(
          email: params.email,
          passwordHash: params.password,
        );

        if (response.statusCode == 200) {
          controller.add(
            User.fromMap(response.data['data']),
          );
          controller.close();
        } else {
          controller.addError(UnrecognizedUseCaseException(exception: null));
        }
      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          controller.addError(InvalidSignInDataException());
        } else {
          controller
              .addError(UnrecognizedNetworkException(response: e.response));
        }
      } catch (e) {
        controller.addError(e);
      }
    } else {
      controller.addError(MissingUseCaseParameterException());
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
    var digest = md5.convert(bytes);

    return digest.toString();
  }
}
