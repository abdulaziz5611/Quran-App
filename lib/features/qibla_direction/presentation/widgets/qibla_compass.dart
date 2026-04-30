import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';

class QiblaCompass extends StatelessWidget {
  /// Qibla bearing in degrees clockwise from true north, [0, 360).
  final double bearingDegrees;
  final double size;

  const QiblaCompass({
    super.key,
    required this.bearingDegrees,
    this.size = 260,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.green700, width: 3),
              color: AppColors.black500,
            ),
          ),
          ..._cardinals(),
          Transform.rotate(
            angle: bearingDegrees * math.pi / 180,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.navigation, color: AppColors.green500, size: 56),
                  Text(
                    'Kaaba',
                    style: GoogleFonts.nunito(
                      color: AppColors.green100,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _cardinals() {
    final labels = {0.0: 'N', 90.0: 'E', 180.0: 'S', 270.0: 'W'};
    return labels.entries.map((entry) {
      final radians = entry.key * math.pi / 180;
      final radius = size / 2 - 18;
      return Transform.translate(
        offset: Offset(radius * math.sin(radians), -radius * math.cos(radians)),
        child: Text(
          entry.value,
          style: GoogleFonts.nunito(
            color: entry.key == 0 ? AppColors.green500 : AppColors.white500,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList();
  }
}
