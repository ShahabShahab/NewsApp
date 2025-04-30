import 'package:domain_layer/src/core/either.dart';
import 'package:domain_layer/src/core/failure/domain_failure.dart';
import 'package:domain_layer/src/features/entity/article.dart';
import 'package:domain_layer/src/features/repository/news_repository.dart';

class GetTopHeadlinesUS {
  final NewsRepository repo;

  GetTopHeadlinesUS({required this.repo});

  Future<Either<DomainFailure, List<Article>>> call({required int page}) async =>
      await repo.getTopHeadlinesUS(page: page);

}
