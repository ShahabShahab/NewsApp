import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:data_layer/src/features/news_list/models/last_article_sync_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDataSourceClient {
  Future<void> initLocalDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ArticleModelAdapter());
    Hive.registerAdapter(LastArticleSyncTimeAdapter());

    await Hive.openBox<ArticleModel>(newsBox);
    await Hive.openBox<LastArticleSyncTime>(lastArticleSyncTimeBox);
  }
}
