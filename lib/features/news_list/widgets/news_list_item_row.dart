import 'package:code_challenge_news_app/core/wigets/news_text.dart';
import 'package:code_challenge_news_app/core/wigets/news_image_holder.dart';
import 'package:domain_layer/domain_layer.dart';
import 'package:flutter/material.dart';
import 'package:resourcing/resourcing.dart';

class NewsListItemRow extends StatelessWidget {
  final Article article;
  final Function onArticleTap;

  const NewsListItemRow(
      {super.key, required this.article, required this.onArticleTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onArticleTap(article),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Card(
              elevation: 3,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewsImageHolder(
                      url: article.urlToImage,
                      height: 80,
                      width: 80,
                      shape: BoxShape.circle,
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: -10,
              child: Transform.rotate(
                angle: 0.785, // 45 degrees in radians
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  color: NewsColors.primary.shade200,
                  child: NewsText(
                    text: article.query.toUpperCase(),
                    style: NewsTextStyles.caption,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
