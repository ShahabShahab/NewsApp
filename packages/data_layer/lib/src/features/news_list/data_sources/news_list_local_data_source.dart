
import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:data_layer/src/features/news_list/models/last_article_sync_time.dart';
import 'package:hive/hive.dart';

class NewsListLocalDataSource {
  static const _key = 'lastSync';

  Future<Box<ArticleModel>> _box() => Hive.openBox<ArticleModel>(newsBox);

  Future<Box<LastArticleSyncTime>> _lastSyncBox() =>
      Hive.openBox<LastArticleSyncTime>(lastArticleSyncTimeBox);

  Future<void> cacheArticles(List<ArticleModel> models) async {
    final box = await _box();
    await box.clear();
    await box.addAll(models);
  }

  Future<void> addArticles(List<ArticleModel> models) async {
    final box = await _box();
    await box.addAll(models);
  }

  Future<List<ArticleModel>> getCachedArticles() async {
    final box = await _box();
    return box.values.toList();
  }

  Future<void> clear() async {
    final box = await _box();
    await box.clear();
  }

  Future<void> saveSyncTime() async {
    final box = await _lastSyncBox();
    final millis = DateTime.now().millisecondsSinceEpoch;
    await box.put(
        _key, LastArticleSyncTime(lastArticleSyncTimeInMillis: millis));
  }

  Future<int?> fetchSyncTime() async {
    final box = await _lastSyncBox();
    final record = box.get(_key);
    return record?.lastArticleSyncTimeInMillis;
  }

  Future<void> clearSyncTime() async {
    final box = await _lastSyncBox();
    await box.delete(_key);
  }
}
