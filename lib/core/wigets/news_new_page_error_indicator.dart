import 'package:code_challenge_news_app/core/wigets/news_text.dart';
import 'package:flutter/material.dart';
import 'package:resourcing/resourcing.dart';

class NewsNewPageErrorIndicator extends StatelessWidget {
  const NewsNewPageErrorIndicator({
    super.key,
    this.onTap,
    required this.message,
  });

  final VoidCallback? onTap;
  final String message;

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewsText(
              text: message,
              style: NewsTextStyles.body.copyWith(color: NewsColors.white),
              align: TextAlign.center,
              maxLines: 100,
            ),
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.refresh,
              size: 32,
              color: NewsColors.white,
            ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ));
}
