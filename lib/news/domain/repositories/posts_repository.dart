import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:dio/dio.dart';

abstract class IPostsRepository {
  Future<Response> getInstitutionalNews();
  Future<Response> create(Post post);
  Future<Response> fetch();
  Future<Stream<Post>> listenNewPosts();
}
