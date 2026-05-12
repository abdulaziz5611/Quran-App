import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';

class QiblaDial extends StatelessWidget {
  /// Bearing to the Kaaba in degrees clockwise from true north, [0, 360).
  final double bearingDegrees;

  /// Diameter of the dial.
  final double size;

  const QiblaDial({
    super.key,
    required this.bearingDegrees,
    this.size = 240,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer dial — filled greenTint with a soft green ring
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.greenTint,
              border: Border.all(
                color: AppColors.green.withValues(alpha: 0.35),
                width: 2,
              ),
            ),
          ),
          // Inner ring — subtle
          Container(
            width: size * 0.78,
            height: size * 0.78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.green.withValues(alpha: 0.18),
                width: 1,
              ),
            ),
          ),
          ..._cardinals(),
          _needle(),
          _kaabaCenter(),
        ],
      ),
    );
  }

  List<Widget> _cardinals() {
    final radius = size / 2 - 18;
    const entries = <(String, double, bool)>[
      ('N', 0, true),
      ('E', 90, false),
      ('S', 180, false),
      ('W', 270, false),
    ];
    return entries.map((e) {
      final (label, deg, isNorth) = e;
      final rad = deg * math.pi / 180;
      return Transform.translate(
        offset: Offset(radius * math.sin(rad), -radius * math.cos(rad)),
        child: Text(
          label,
          style: GoogleFonts.nunito(
            color: isNorth ? AppColors.green : AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList();
  }

  Widget _needle() {
    final radians = bearingDegrees * math.pi / 180;
    return Transform.rotate(
      angle: radians,
      child: SizedBox(
        width: size,
        height: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size * 0.14),
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: AppColors.green,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2.5,
              height: size * 0.30,
              color: AppColors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _kaabaCenter() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.gold, width: 1.5),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.mosque, color: AppColors.gold, size: 20),
    );
  }
}
