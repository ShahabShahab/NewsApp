import 'package:domain_layer/src/core/either.dart';
import 'package:domain_layer/src/core/failure/domain_failure.dart';
import 'package:domain_layer/src/features/entity/article.dart';

abstract class NewsRepository{
  Future<Either<DomainFailure, List<Article>>> getTopHeadlinesUS({required int page});
}