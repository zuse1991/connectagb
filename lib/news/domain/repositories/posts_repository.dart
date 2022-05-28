import 'package:dio/dio.dart';

abstract class IPostsRepository {
  Future<Response> getInstitutionalNews();
}
