import 'dart:ffi';

import 'package:data_layer/src/core/local_data_base_type_ids.dart';
import 'package:hive/hive.dart';

part 'last_article_sync_time.g.dart';

@HiveType(typeId: lastArticleSyncTimeTypeID)
class LastArticleSyncTime {
  @HiveField(0)
  final int lastArticleSyncTimeInMillis;

  LastArticleSyncTime({required this.lastArticleSyncTimeInMillis});
}
