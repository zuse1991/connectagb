import 'package:dio/dio.dart';

abstract class IPostsRepository {
  Future<Response> getInstitutionalNews();
  Future<Response> create(Map post);
  Future<Response> fetch();
  Future<Stream<Map>> listenNewPosts();
  Future<Response> update(int id, String newContent);
  Future<Response> delete(int id);

  void dispose();
}
