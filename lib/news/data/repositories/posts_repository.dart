import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsRepository extends IPostsRepository {
  @override
  Future<Response> getInstitutionalNews() {
    return Dio().get('https://gb-mobile-app-teste.s3.amazonaws.com/data.json');
  }
}
