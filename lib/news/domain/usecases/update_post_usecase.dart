import 'dart:async';

import 'package:conecta_gb/commom/exceptions/missing_usecase_parameter_exception.dart';
import 'package:conecta_gb/commom/exceptions/unrecognized_network_exception.dart';
import 'package:conecta_gb/commom/exceptions/unrecognized_usecase_exception.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class UpdatePostUseCase extends CompletableUseCase<UpdatePostUseCaseParam> {
  UpdatePostUseCase(this._repository);
  final IPostsRepository _repository;

  @override
  Future<Stream<void>> buildUseCaseStream(
      UpdatePostUseCaseParam? params) async {
    StreamController controller = StreamController();

    if (params != null) {
      try {
        await _repository.update(params.post.id, params.newContent);
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

class UpdatePostUseCaseParam {
  UpdatePostUseCaseParam(this.post, this.newContent);

  final Post post;
  final String newContent;
}
