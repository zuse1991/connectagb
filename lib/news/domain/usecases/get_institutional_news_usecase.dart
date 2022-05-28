import 'dart:async';

import 'package:conecta_gb/commom/exceptions/unrecognized_network_exception.dart';
import 'package:conecta_gb/commom/exceptions/unrecognized_usecase_exception.dart';
import 'package:conecta_gb/news/domain/models/institutional_message.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetInstitutionalNewsUseCase
    extends UseCase<List<InstitutionalMessage>, void> {
  GetInstitutionalNewsUseCase(this._postsRepository);
  final IPostsRepository _postsRepository;

  @override
  Future<Stream<List<InstitutionalMessage>?>> buildUseCaseStream(
    void params,
  ) async {
    final controller = StreamController<List<InstitutionalMessage>>();

    try {
      final response = await _postsRepository.getInstitutionalNews();

      final data = (response.data['news'] as List).map<InstitutionalMessage>(
        (current) => InstitutionalMessage.fromMap(current),
      );

      controller.add(data.toList());
      controller.close();
    } on DioError catch (e) {
      controller.addError(UnrecognizedNetworkException(response: e.response));
    } catch (e) {
      controller.addError(UnrecognizedUseCaseException(exception: e));
    }

    return controller.stream;
  }
}
