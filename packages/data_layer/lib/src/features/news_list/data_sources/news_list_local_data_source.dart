import 'package:data_layer/src/core/constants.dart';
import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:hive/hive.dart';

class NewsListLocalDataSource {
  final String boxName;

  NewsListLocalDataSource({this.boxName = newsBox});

  Future<Box<ArticleModel>> _box() => Hive.openBox<ArticleModel>(boxName);

  Future<void> cacheArticles(List<ArticleModel> models) async {
    final box = await _box();
    await box.clear();
    await box.addAll(models);
  }

  Future<void> addArticles(List<ArticleModel> models) async {
    final box = await _box();
    await box.addAll(models);
  }

  Future<List<ArticleModel>> getCachedArticles(int page,
      {int pageSize = pageSize}) async {
    final box = await _box();
    final articleList = box.values.toList();
    final offset = ((page - 1) * pageSize);
    if (_hasAlreadyReachedTheEndOfTheList(offset, articleList.length)) {
      throw offlineFirstListHasAlreadyEndedErrorMessage;
    } else if (_hasReachedTheEndOfTheList(offset, articleList.length)) {
      return [];
    } else if (_isAboutToReachTheEndOfTheList(
        offset, pageSize, articleList.length)) {
      return box.values.toList().sublist(offset);
    } else {
      return box.values.toList().sublist(offset, offset + pageSize);
    }
  }

  bool _hasAlreadyReachedTheEndOfTheList(int offset, int elementsListLength) =>
      offset > elementsListLength;

  bool _hasReachedTheEndOfTheList(int offset, int elementsListLength) =>
      offset == elementsListLength;

  bool _isAboutToReachTheEndOfTheList(
          int offset, int pageSize, int elementsListLength) =>
      offset + pageSize > elementsListLength;

  Future<void> clear() async {
    final box = await _box();
    await box.clear();
  }
}
