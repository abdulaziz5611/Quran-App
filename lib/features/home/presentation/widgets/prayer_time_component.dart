import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';

class PrayerTimeComponent extends StatelessWidget {
  final String prayerNameEng;
  final String prayerNameArab;
  final String prayerTime;
  final IconData iconData;
  final String remainingTime;

  const PrayerTimeComponent({
    super.key,
    required this.prayerNameEng,
    required this.prayerNameArab,
    required this.prayerTime,
    required this.iconData,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.green700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(iconData, color: AppColors.white500, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      prayerNameEng,
                      style: GoogleFonts.nunito(
                        color: AppColors.white500,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      prayerNameArab,
                      style: GoogleFonts.nunito(
                        color: AppColors.green100,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'in $remainingTime',
                  style: GoogleFonts.nunito(
                    color: AppColors.green100,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            prayerTime,
            style: GoogleFonts.nunito(
              color: AppColors.white500,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
