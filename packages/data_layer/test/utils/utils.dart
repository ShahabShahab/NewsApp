import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:data_layer/src/features/news_list/models/get_top_headline_response.dart';
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
        sourceName: element.source?.name,
        author: element.author ?? "---");
  }).toList();
}

GetTopHeadlineResponse createGetTopHeadlineResponse() {
  return GetTopHeadlineResponse(status: "ok", totalResults: 19363, articles: [
    ArticleModel(
        source: Source(id: "the-verge", name: "The Verge"),
        title: "Microsoft turns 50",
        author: "Tom Warren",
        description:
            "Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software that helped it achieve an early goal of a PC on every desk and …",
        url: "https://www.theverge.com/news/643336/microsoft-50-years",
        urlToImage:
            "https://platform.theverge.com/wp-content/uploads/sites/2/2025/03/microsoftoldlogo.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200",
        publishedAt: DateTime.tryParse("2025-04-04T13:21:07Z"),
        content:
            "Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software tha… [+2822 chars]"),
    ArticleModel(
        source: Source(id: "the-verge", name: "The Verge"),
        title: "Microsoft turns 50",
        author: "Tom Warren",
        description:
            "Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software that helped it achieve an early goal of a PC on every desk and …",
        url: "https://www.theverge.com/news/643336/microsoft-50-years",
        urlToImage:
            "https://platform.theverge.com/wp-content/uploads/sites/2/2025/03/microsoftoldlogo.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200",
        publishedAt: DateTime.tryParse("2025-04-04T13:21:07Z"),
        content:
            "Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software tha… [+2822 chars]"),
    ArticleModel(
        source: Source(id: "the-verge", name: "The Verge"),
        title: "Microsoft turns 50",
        author: "Tom Warren",
        description:
            "Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software that helped it achieve an early goal of a PC on every desk and …",
        url: "https://www.theverge.com/news/643336/microsoft-50-years",
        urlToImage:
            "https://platform.theverge.com/wp-content/uploads/sites/2/2025/03/microsoftoldlogo.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200",
        publishedAt: DateTime.tryParse("2025-04-04T13:21:07Z"),
        content:
            "Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software tha… [+2822 chars]"),
  ]);
}
