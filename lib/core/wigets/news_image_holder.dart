import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_challenge_news_app/core/wigets/news_text.dart';
import 'package:code_challenge_news_app/core/wigets/news_svg.dart';
import 'package:code_challenge_news_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:resourcing/resourcing.dart';

class NewsImageHolder extends StatelessWidget {
  const NewsImageHolder({
    super.key,
    required this.url,
    required this.height,
    required this.width,
    this.imageSize,
    this.fit,
    this.radius,
    this.borderShape,
    this.isPath = false,
  });

  final String? url;
  final bool isPath;
  final double height;
  final double width;
  final int? imageSize;
  final BoxFit? fit;
  final double? radius;
  final BorderRadius? borderShape;

  @override
  Widget build(final BuildContext context) {
    return isPath
        ? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: borderShape ?? BorderRadius.circular(radius ?? 16),
              image: DecorationImage(
                image: FileImage(
                  File(url ?? ''),
                ),
                fit: fit ?? BoxFit.contain,
              ),
            ),
          )
        : CachedNetworkImage(
            imageUrl: url ?? "---",
            placeholder: (context, url) =>
                SizedBox(width: 40, child: NewsText(text: "Loading...", style: NewsTextStyles.overLine)),
            errorWidget: (_, s, e) => NewsSvg(assetName: Assets.imageError),
            //  SIZE IMG 50 100 300 500 767
            imageBuilder: (
              final context,
              final imageProvider,
            ) =>
                Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius:
                    borderShape ?? BorderRadius.circular(radius ?? 16),
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit ?? BoxFit.contain,
                ),
              ),
            ),
            fit: BoxFit.cover,
          );
  }
}
