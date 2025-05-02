import 'package:code_challenge_news_app/core/utils/date_service.dart';
import 'package:code_challenge_news_app/core/utils/url_service.dart';
import 'package:code_challenge_news_app/core/wigets/news_image_holder.dart';
import 'package:code_challenge_news_app/core/wigets/news_text.dart';
import 'package:flutter/material.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:intl/intl.dart';
import 'package:resourcing/resourcing.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NewsText(
          text: article.sourceName ?? "---",
          style: NewsTextStyles.subtitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewsImageHolder(
              url: article.urlToImage,
              width: double.infinity,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  NewsText(
                    text: article.title,
                    style: NewsTextStyles.heading1,
                  ),
                  const SizedBox(height: 12),
                  NewsText(
                    text: article.author ?? "---",
                    style: NewsTextStyles.subtitle,
                  ),
                  NewsText(
                    text: article.publishedAt != null
                        ? DateService.convertToDateTimeToUserReadableDate(
                            article.publishedAt!)
                        : "---",
                    style: NewsTextStyles.heading4,
                  ),
                  const SizedBox(height: 20),
                  NewsText(
                    text: article.description,
                    style: NewsTextStyles.body,
                  ),
                  const SizedBox(height: 20),
                  NewsText(
                    text: article.content,
                    style: NewsTextStyles.body1,
                    overflow: TextOverflow.visible,
                    maxLines: 100,
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        UrlService.openUrl(article.url);
                      },
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Read Full Article'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
