import 'package:conecta_gb/commom/exceptions/unrecognized_network_exception.dart';
import 'package:conecta_gb/news/domain/models/institutional_message.dart';
import 'package:conecta_gb/news/domain/usecases/get_institutional_news_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/default_test_observer.dart';
import '../../data/posts_repository_mock.dart';

void main() {
  group('GetInstitutionalNews usecase test', () {
    late PostsRepositoryMock repository;
    late GetInstitutionalNewsUseCase useCase;
    late DefaultTestObserver<List<InstitutionalMessage>> observer;

    setUp(() {
      repository = PostsRepositoryMock();
      useCase = GetInstitutionalNewsUseCase(repository);
      observer = DefaultTestObserver<List<InstitutionalMessage>>();
    });

    test('Success result from UseCase', () async {
      useCase.execute(observer);
      while (!observer.ended) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 5));
      }

      expect(observer.done, true);
      expect(observer.error, false);
      expect(
        observer.data,
        const TypeMatcher<List>(),
      );
      expect(observer.data?.length, 2);
    });

    test('Exception result from UseCase', () async {
      repository.failTest = true;
      useCase.execute(observer);
      while (!observer.ended) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 5));
      }

      expect(observer.done, false);
      expect(observer.error, true);
      expect(
        observer.exception,
        const TypeMatcher<UnrecognizedNetworkException>(),
      );
    });
  });
}
