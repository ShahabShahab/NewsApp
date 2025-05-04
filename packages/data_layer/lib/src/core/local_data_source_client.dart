import 'package:data_layer/src/core/keys.dart';
import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:hive/hive.dart';

class LocalDataSourceClient {
  Future<void> initLocalDatabase({required String directory}) async {
    Hive.init(directory);
    Hive.registerAdapter(ArticleModelAdapter(), override: true);
    Hive.registerAdapter(SourceAdapter(), override: true);

    await Hive.openBox<ArticleModel>(newsBox);
  }
}
