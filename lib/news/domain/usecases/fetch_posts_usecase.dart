import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FetchPostsUseCase extends UseCase<List<Post>, void> {
  @override
  Future<Stream<List<Post>?>> buildUseCaseStream(void params) {}
}
