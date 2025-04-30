import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsSvg extends StatelessWidget {
  const NewsSvg(
      {super.key,
      required this.assetName,
      this.width,
      this.height,
      this.color});

  final String assetName;
  final double? width, height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width ?? 24,
      height: height ?? 24,
      color: color,
      fit: BoxFit.cover,
    );
  }
}
