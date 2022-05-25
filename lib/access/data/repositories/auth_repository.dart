import 'package:conecta_gb/access/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<Response> authenticate({
    required String email,
    required String passwordHash,
  }) async {
    // TODO: implement authenticate
    throw UnimplementedError();
  }
}
