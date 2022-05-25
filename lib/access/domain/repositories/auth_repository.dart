import 'package:dio/dio.dart';

abstract class IAuthRepository {
  Future<Response> authenticate({
    required String email,
    required String passwordHash,
  });
}
