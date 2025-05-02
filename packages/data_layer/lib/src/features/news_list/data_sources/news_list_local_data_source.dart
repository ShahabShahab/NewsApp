import 'package:data_layer/src/core/constants.dart';
import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:hive/hive.dart';

class NewsListLocalDataSource {
  Future<Box<ArticleModel>> _box() => Hive.openBox<ArticleModel>(newsBox);

  Future<void> cacheArticles(List<ArticleModel> models) async {
    final box = await _box();
    await box.clear();
    await box.addAll(models);
  }

  Future<void> addArticles(List<ArticleModel> models) async {
    final box = await _box();
    await box.addAll(models);
  }

  Future<List<ArticleModel>> getCachedArticles(int page) async {
    final box = await _box();
    final articleList = box.values.toList();
    if (articleList.isEmpty) return [];
    if (page == 1) {
      return articleList.sublist(0, pageSize);
    } else {
      final offset = ((page - 1) * pageSize);
      if (offset >= articleList.length) {
        return [];
      } else if (offset + pageSize > articleList.length) {
        return box.values.toList().sublist(offset);
      }
      return box.values.toList().sublist(offset, offset + pageSize);
    }
  }

  Future<void> clear() async {
    final box = await _box();
    await box.clear();
  }
}
