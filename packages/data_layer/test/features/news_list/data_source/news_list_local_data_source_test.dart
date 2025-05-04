import 'package:data_layer/data_layer.dart';
import 'package:data_layer/src/core/constants.dart';
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
      tArticles = _createTestArticles();
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

  group("addArticles method tests", () {
    late List<ArticleModel> tArticles;
    setUp(() {
      tArticles = _createTestArticles();
    });
    test("addArticles must not clear the previously added articles", () async {
      //arrange

      //act

      await localDataSource.addArticles(tArticles);
      await localDataSource.addArticles(tArticles);

      //assert
      expect(testBox.values.length, equals(6));
      expect(testBox.values.elementAt(5).title, equals("2 Title"));
    });
  });

  group("clear method", () {
    late List<ArticleModel> tArticles;
    setUp(() {
      tArticles = _createTestArticles();
    });

    test("the box must get cleared after clear method get called", () async {
      //arrange

      //act

      await localDataSource.addArticles(tArticles);
      await localDataSource.clear();

      //assert

      expect(testBox.values.isEmpty, isTrue);
    });
  });

  group("getCachedArticles", () {
    late List<ArticleModel> tArticles;
    setUp(() {
      tArticles = _createTestArticles();
    });
    test("must return an empty list once the box is empty", () async {
      //arrange

      //act

      final result = await localDataSource.getCachedArticles(1);

      //assert

      expect(result.isEmpty, isTrue);
    });

    test("once the list has fewer elements than the page size", () async {
      //arrange

      tArticles = _createTestArticles(numberOfItems: 17);
      await localDataSource.cacheArticles(tArticles);

      //act

      final result = await localDataSource.getCachedArticles(1, pageSize: 25);

      //assert

      expect(result.length, equals(17));
    });

    test("once the list has the exact number of elements of the page size",
        () async {
      //arrange

      tArticles = _createTestArticles(numberOfItems: 17);
      await localDataSource.cacheArticles(tArticles);

      //act

      final result = await localDataSource.getCachedArticles(1, pageSize: 17);

      //assert

      expect(result.length, equals(17));
    });

    test(
        "once the number of elements in the list is greater than the page size, the returned elements is equal to the page size",
        () async {
      //arrange
      final tPageSize = 17;
      tArticles = _createTestArticles(numberOfItems: 19);
      await localDataSource.cacheArticles(tArticles);

      //act
      final result =
          await localDataSource.getCachedArticles(1, pageSize: tPageSize);
      //assert
      expect(result.length, equals(tPageSize));
    });

    test(
        "once the offset is bigger than the element size, an exception String should be thrown",
        () async {
      //arrange

      final tPageSize = 20;
      tArticles = _createTestArticles(numberOfItems: 22);
      await localDataSource.cacheArticles(tArticles);
      //act
      //assert
      expect(
        () async =>
            await localDataSource.getCachedArticles(3, pageSize: tPageSize),
        throwsA(
            predicate((e) => e == offlineFirstListHasAlreadyEndedErrorMessage)),
      );
    });
  });
}

List<ArticleModel> _createTestArticles({int numberOfItems = 3}) {
  return List.generate(numberOfItems, (index) {
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
}
