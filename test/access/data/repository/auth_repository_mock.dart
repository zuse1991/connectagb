import 'package:conecta_gb/access/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepositoryMock implements IAuthRepository {
  @override
  Future<Response> authenticate({
    required String email,
    required String passwordHash,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    switch (passwordHash) {
      case '003670073a9089519ebbfc4143d00821': //grupoboticario
        final header = Headers()
          ..add('set-cookie',
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c');
        return Response(
          requestOptions: RequestOptions(
            path: '',
          ),
          headers: header,
          statusCode: 200,
          data: {
            'data': {
              'gender': 'male',
              'name': 'Andrei Jiácomo Zuse',
              'email': 'andrei.j.zuse@gmail.com',
              'dob': {'date': '1991-10-20T00:00:00.000Z', 'age': 30},
              'registered': {'date': '2016-02-10T02:36:36.980Z', 'age': 6},
              'picture': {
                'large': 'https://randomuser.me/api/portraits/men/72.jpg',
                'medium': 'https://randomuser.me/api/portraits/med/men/72.jpg',
                'thumbnail':
                    'https://randomuser.me/api/portraits/thumb/men/72.jpg'
              },
            },
          },
        );
      case '2bda2998d9b0ee197da142a0447f6725': //wrong
        throw DioError(
          requestOptions: RequestOptions(
            path: '',
          ),
          response: Response(
            requestOptions: RequestOptions(
              path: '',
            ),
            statusCode: 404,
            data: {
              'error': {
                'code': 404,
                'message': 'invalid_login_data',
              }
            },
          ),
        );
      default:
        throw DioError(
          requestOptions: RequestOptions(
            path: '',
          ),
          type: DioErrorType.receiveTimeout,
        );
    }
  }
}
