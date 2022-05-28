import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SendPostUseCase extends CompletableUseCase<SendPostParam> {
  @override
  Future<Stream<void>> buildUseCaseStream(SendPostParam? params) {}
}

class SendPostParam {
  SendPostParam({required this.user, required this.message});

  final String message;
  final User user;
}
