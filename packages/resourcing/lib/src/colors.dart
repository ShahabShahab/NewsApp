import 'dart:math';

import 'package:flutter/material.dart';

class NewsColors {

  static Color white = Color(0xFFFFFFFF);

  static const ColorMaterial primary = ColorMaterial(
    shade10: Color(0xFFFFFFFF),
    shade50: Color(0xFFFFEBEE),
    shade100: Color(0xFFFCE2E2),
    shade200: Color(0xFFEF9A9A),
    shade300: Color(0xFFFF9996),
    shade400: Color(0xFFEF5350),
    shade500: Color(0xFFF96864),
    shade600: Color(0xFFF96864),
    shade700: Color(0xFFD1403C),
    shade800: Color(0xFFB71C1C),
    shade900: Color(0xFF880E4F),
  );

  static const ColorMaterial secondary = ColorMaterial(
    shade10: Color(0xFFF1FCFF),
    shade50: Color(0xFFEDF9FF),
    shade100: Color(0xFFC9ECFD),
    shade200: Color(0xFF9FDDFC),
    shade300: Color(0xFF9FDDFC),
    shade400: Color(0xFF48BEF8),
    shade500: Color(0xFF20B0F7),
    shade600: Color(0xFF1B96D2),
    shade700: Color(0xFF177DAF),
    shade800: Color(0xFF12648D),
    shade900: Color(0xFF12648D),
  );

  static const Color background = Color(0xFFF5F5F5);
  static const Color darkBackground = Color(0xFF333333);
  static const Color cardBackground = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF404040);
  static const Color textSecondary = Color(0xFF171717);
  static const Color textButton = Color(0xFF333333);
  static const Color textHint = Color(0xFFBDBDBD);

  static const Color itineraryDay1 = Color(0xFFFF2056);
  static const Color itineraryDay2 = Color(0xFF615FFF);
  static const Color itineraryDay3 = Color(0xFF00A63E);
  static const Color itineraryDay4 = Color(0xFFC800DE);
  static const Color itineraryDay5 = Color(0xFFE17100);

  static const Color attractionHotel = Color(0xFFF96864);
  static const Color attractionFood = Color(0xFFFF6900);
  static const Color attractionTourism = Color(0xFF7F22FE);
  static const Color attractionShopping = Color(0xFF00B8DB);
  static const Color attractionNature = Color(0xFF497D00);

  static const ColorMaterial gray = ColorMaterial(
    shade10: Color(0xFFF9FAEA),
    shade50: Color(0xFFF9FAFB),
    shade100: Color(0xFFF3F4F6),
    shade200: Color(0xFFE5E7EB),
    shade300: Color(0xFFD1D5DC),
    shade400: Color(0xFF99A1AF),
    shade500: Color(0xFF6A7282),
    shade600: Color(0xFF4A5565),
    shade700: Color(0xFF364153),
    shade800: Color(0xFF1E2939),
    shade900: Color(0xFF101828),
  );

  static const ColorMaterial orange = ColorMaterial(
    shade10: Color(0xFFFFF4E6),
    shade50: Color(0xFFFFE0B2),
    shade100: Color(0xFFFFCC80),
    shade200: Color(0xFFFFA64D),
    shade300: Color(0xFFFF8500),
    shade400: Color(0xFFFF7800),
    shade500: Color(0xFFFF6900),
    shade600: Color(0xFFE65D00),
    shade700: Color(0xFFCC5200),
    shade800: Color(0xFFB34700),
    shade900: Color(0xFF802F00),
  );

  static const ColorMaterial red = ColorMaterial(
    shade10: Color(0xFFFDE8E8),
    shade50: Color(0xFFFFEBEE),
    shade100: Color(0xFFE02424),
    shade200: Color(0xFFC81E1E),
    shade300: Color(0xFF9B1C1C),
    shade400: Color(0xFFB71C1C),
    shade500: Color(0xFFE33F4C),
    shade600: Color(0xFF9B1C1C),
    shade700: Color(0xFFC81E1E),
    shade800: Color(0xFFE02424),
    shade900: Color(0xFFD32F2F),
  );

  static const Color divider = Color(0xFFBDBDBD);
  static const Color shadow = Color(0x40000000);

  static const Color accent = Color(0xFF00C853);
  static const Color error = Color(0xFFD32F2F);

  static const Color pastel01 = Color(0xFFFEFCE8);
  static const Color pastel02 = Color(0xFFFEF2F2);
  static const Color pastel03 = Color(0xFFECFDF5);
  static const Color pastel04 = Color(0xFFF5F3FF);
  static const Color pastel05 = Color(0xFFECFEFF);

  static Color getRandomColor() {
    List<Color> attractionColors = [
      attractionHotel,
      attractionFood,
      attractionTourism,
      attractionShopping,
      attractionNature,
    ];
    final random = Random();
    return attractionColors[random.nextInt(attractionColors.length)];
  }
}

class ColorMaterial {
  const ColorMaterial({
    required this.shade10,
    required this.shade50,
    required this.shade100,
    required this.shade200,
    required this.shade300,
    required this.shade400,
    required this.shade500,
    required this.shade600,
    required this.shade700,
    required this.shade800,
    required this.shade900,
  });

  final Color shade10;
  final Color shade50;
  final Color shade100;
  final Color shade200;
  final Color shade300;
  final Color shade400;
  final Color shade500;
  final Color shade600;
  final Color shade700;
  final Color shade800;
  final Color shade900;

  static ColorMaterial lerp(
    final ColorMaterial? a,
    final ColorMaterial? b,
    final double t,
  ) {
    if (a == null || b == null) return a ?? b!;
    return ColorMaterial(
      shade10: Color.lerp(a.shade10, b.shade10, t)!,
      shade50: Color.lerp(a.shade50, b.shade50, t)!,
      shade100: Color.lerp(a.shade100, b.shade100, t)!,
      shade200: Color.lerp(a.shade200, b.shade200, t)!,
      shade300: Color.lerp(a.shade300, b.shade300, t)!,
      shade400: Color.lerp(a.shade400, b.shade400, t)!,
      shade500: Color.lerp(a.shade500, b.shade500, t)!,
      shade600: Color.lerp(a.shade600, b.shade600, t)!,
      shade700: Color.lerp(a.shade700, b.shade700, t)!,
      shade800: Color.lerp(a.shade800, b.shade800, t)!,
      shade900: Color.lerp(a.shade900, b.shade900, t)!,
    );
  }
}
