import 'dart:async';

import 'package:conecta_gb/commom/exceptions/missing_usecase_parameter_exception.dart';
import 'package:conecta_gb/commom/exceptions/unrecognized_network_exception.dart';
import 'package:conecta_gb/commom/exceptions/unrecognized_usecase_exception.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeletePostUseCase extends CompletableUseCase<Post> {
  DeletePostUseCase(this._repository);
  final IPostsRepository _repository;

  @override
  Future<Stream<void>> buildUseCaseStream(Post? params) async {
    StreamController controller = StreamController();

    if (params != null) {
      try {
        await _repository.delete(params.id);
        controller.close();
      } on DioError catch (e) {
        controller.addError(UnrecognizedNetworkException(response: e.response));
      } catch (e) {
        controller.addError(UnrecognizedUseCaseException(exception: e));
      }
    } else {
      controller.addError(MissingUseCaseParameterException());
    }

    return controller.stream;
  }
}
