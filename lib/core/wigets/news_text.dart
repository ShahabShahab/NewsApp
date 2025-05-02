import 'package:flutter/material.dart';

class NewsText extends StatelessWidget {
  const NewsText(
      {super.key,
      required this.text,
      required this.style,
      this.maxLines = 1,
      this.overflow});

  final String text;
  final TextStyle style;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
