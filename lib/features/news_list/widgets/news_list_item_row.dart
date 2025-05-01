import 'package:code_challenge_news_app/core/wigets/news_text.dart';
import 'package:code_challenge_news_app/core/wigets/news_image_holder.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:flutter/material.dart';
import 'package:resourcing/resourcing.dart';

class NewsListItemRow extends StatelessWidget {
  final Article article;

  const NewsListItemRow({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            NewsImageHolder(
              url: article.url,
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewsText(
                    text: article.title,
                    style: NewsTextStyles.heading3,
                  ),
                  const SizedBox(height: 6),
                  NewsText(
                    text: article.description,
                    style: NewsTextStyles.body1,
                  ),
                  const SizedBox(height: 6),
                  NewsText(
                    text: article.content,
                    style: NewsTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
