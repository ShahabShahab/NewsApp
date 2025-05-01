import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:data_layer/src/features/news_list/models/last_article_sync_time.dart';
import 'package:hive/hive.dart';

class LocalDataSourceClient {
  Future<void> initLocalDatabase({required String directory}) async {
    Hive.init(directory);
    Hive.registerAdapter(ArticleModelAdapter());
    Hive.registerAdapter(LastArticleSyncTimeAdapter());
    Hive.registerAdapter(SourceAdapter());

    await Hive.openBox<ArticleModel>(newsBox);
    await Hive.openBox<LastArticleSyncTime>(lastArticleSyncTimeBox);
  }
}
