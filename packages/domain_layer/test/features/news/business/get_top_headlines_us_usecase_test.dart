import 'dart:math';

import 'package:domain_layer/src/core/either.dart';
import 'package:domain_layer/src/core/failure/domain_failure.dart';
import 'package:domain_layer/src/core/failure/server_failure.dart';
import 'package:domain_layer/src/features/business/get_top_headlines_us.dart';
import 'package:domain_layer/src/features/entity/article.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:mocktail/mocktail.dart';

import 'get_top_headlines_us_mocks.dart';

void main() {
  late GetTopHeadlinesUS getTopHeadlinesUS;
  late MockNewsRepository mockNewsRepository;

  setUpAll(() {
    mockNewsRepository = MockNewsRepository();
    getTopHeadlinesUS = GetTopHeadlinesUS(repo: mockNewsRepository);
  });

  group("GetTopHeadlinesUS", () {
    test("delegates to repository and returns its value", () async {
      const tArticles = <Article>[];
      //arrange

      when(() => mockNewsRepository.getTopHeadlinesUS())
          .thenAnswer((_) async => const Right(value: tArticles));

      //act

      final result = await getTopHeadlinesUS();

      //assert

      expect(
        result,
        equals(const Right<DomainFailure, List<Article>>(value: tArticles)),
      );
      expect(result.isRight, isTrue);
      expect(result.isLeft, isFalse);
      verify(() => mockNewsRepository.getTopHeadlinesUS()).called(1);
      verifyNoMoreInteractions(mockNewsRepository);
    });

    test("the repository must return failure in case of something went wrong",
        () async {
      final tServerFailure = ServerFailure();

      //arrange

      when(() => mockNewsRepository.getTopHeadlinesUS())
          .thenAnswer((_) async => Left(value: tServerFailure));

      //act
      final result = await getTopHeadlinesUS();

      //assert
      expect(result,
          equals(Left<DomainFailure, List<Article>>(value: tServerFailure)));
      expect(result.isLeft, isTrue);
      expect(result.isRight, isFalse);
      verify(() => mockNewsRepository.getTopHeadlinesUS()).called(1);
      verifyNoMoreInteractions(mockNewsRepository);
    });
  });
}
