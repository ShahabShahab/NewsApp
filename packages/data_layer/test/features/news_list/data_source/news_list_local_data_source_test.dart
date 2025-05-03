import 'package:data_layer/data_layer.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  late NewsListLocalDataSource localDataSource;
  const testBoxName = "test_box_name";
  late Box<ArticleModel> testBox;

  setUpAll(() {
    Hive.registerAdapter(ArticleModelAdapter());
    Hive.registerAdapter(SourceAdapter());
  });
  void isBoxOpen() {
    final result = testBox.isOpen;
    expect(result, isTrue);
  }

  setUp(() async {
    await setUpTestHive();
    testBox = await Hive.openBox<ArticleModel>(testBoxName);
    localDataSource = NewsListLocalDataSource(boxName: testBoxName);
    isBoxOpen();
  });

  tearDown(() async {
    await tearDownTestHive();
    await Hive.close();
  });

  group("cacheArticles() method tests", () {
    late List<ArticleModel> tArticles;
    setUp(() {
      tArticles = List.generate(3, (index) {
        return ArticleModel(
            title: "$index Title",
            description: "$index description",
            url: "$index url",
            urlToImage: "$index urlToImage",
            publishedAt: DateTime.now().subtract(Duration(days: index)),
            content: "$index content",
            source: Source(id: "$index id", name: "$index name"),
            query: "$index query",
            author: "$index author");
      });
    });

    test(
        "cacheArticles must first clear the articles thereAfter add the new ones",
        () async {
      //arrange

      //act
      await localDataSource.cacheArticles(tArticles);
      await localDataSource.cacheArticles(tArticles);

      //assert
      isBoxOpen();
      expect(testBox.values.length, equals(3));
    });
  });
}
