import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:domain_layer/domain_layer.dart';

List<ArticleModel> createTestArticleModels({int numberOfItems = 3}) {
  final dateTimeNow = DateTime.now();
  return List.generate(numberOfItems, (index) {
    return ArticleModel(
        title: "$index Title",
        description: "$index description",
        url: "$index url",
        urlToImage: "$index urlToImage",
        publishedAt: dateTimeNow.subtract(Duration(days: index)),
        content: "$index content",
        source: Source(id: "$index id", name: "$index name"),
        query: "$index query",
        author: "$index author");
  });
}

List<Article> createTestArticles({int numberOfItems = 3}) {
  final dateTimeNow = DateTime.now();
  return List.generate(numberOfItems, (index) {
    return Article(
        title: "$index Title",
        description: "$index description",
        url: "$index url",
        urlToImage: "$index urlToImage",
        publishedAt: dateTimeNow.subtract(Duration(days: index)),
        content: "$index content",
        query: "$index query",
        author: "$index author");
  });
}

List<Article> createTestArticlesBasedOnArticleModels(
    List<ArticleModel> articleModels) {
  return articleModels.map((element) {
    return Article(
        title: element.title ?? "---",
        description: element.description ?? "---",
        url: element.url ?? "---",
        urlToImage: element.urlToImage ?? "---",
        publishedAt: element.publishedAt ?? DateTime.now(),
        content: element.content ?? "---",
        query: element.query ?? "---",
        author: element.author ?? "---");
  }).toList();
}
