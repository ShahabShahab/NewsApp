import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class UrlService {
  const UrlService._();

  static Future<bool> openUrl(String url,
      {LaunchMode mode = LaunchMode.externalApplication}) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri, mode: mode);
    } else {
      throw 'Cannot launch URL: $url';
    }
  }
}
