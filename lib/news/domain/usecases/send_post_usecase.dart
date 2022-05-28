import 'dart:async';

import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/commom/exceptions/missing_usecase_parameter_exception.dart';
import 'package:conecta_gb/news/domain/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SendPostUseCase extends CompletableUseCase<SendPostParam> {
  SendPostUseCase(this._postsRepository);
  final IPostsRepository _postsRepository;

  @override
  Future<Stream<void>> buildUseCaseStream(SendPostParam? params) async {
    final controller = StreamController();

    if (params != null) {
      await _postsRepository.create(params.toMap());
      controller.close();
    } else {
      controller.addError(MissingUseCaseParameterException());
    }

    return controller.stream;
  }
}

class SendPostParam {
  SendPostParam({required this.user, required this.message});

  final String message;
  final User user;

  Map toMap() => {
        'user': {
          'name': user.name,
          'profile_picture': user.picture.large,
          'email': user.email,
        },
        'message': {
          'content': message,
        },
      };
}
