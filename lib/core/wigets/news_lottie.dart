import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NewsLottie extends StatelessWidget {
  const NewsLottie({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/LottieLogo1.json',
        width: width ?? double.maxFinite, height: height ?? double.maxFinite);
  }
}
