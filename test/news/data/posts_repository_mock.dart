import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class PostsRepositoryMock with Mock implements IPostsRepository {
  bool failTest = false;

  @override
  Future<Response> getInstitutionalNews() async {
    if (!failTest) {
      return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {
            'news': [
              {
                'user': {
                  'name': 'O Boticário',
                  'profile_picture':
                      'https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png'
                },
                'message': {
                  'content':
                      'Além disso, nossos funcionários e familiares receberão kits de proteção. Afinal, o cuidado começa aqui dentro, né?',
                  'created_at': '2020-02-02T16:10:33Z'
                }
              },
              {
                'user': {
                  'name': 'O Boticário',
                  'profile_picture':
                      'https://gb-mobile-app-teste.s3.amazonaws.com/oboticario.png'
                },
                'message': {
                  'content':
                      'Com a união das demais marcas do grupo, doamos 216 toneladas de produtos de higiene para comunidades em vulnerabilidade social de diversas partes do país.',
                  'created_at': '2020-02-02T15:10:33Z'
                }
              },
            ]
          });
    }

    throw DioError(
      requestOptions: RequestOptions(path: ''),
      type: DioErrorType.connectTimeout,
    );
  }
}
