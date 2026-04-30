import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';

class DateRow extends StatelessWidget {
  const DateRow({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hijri = HijriCalendar.fromDate(now);
    final hijriText =
        '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} AH';
    final gregorianText = DateFormat.yMMMMd().format(now);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.green200),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_outlined,
              color: AppColors.green500, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hijriText,
                  style: GoogleFonts.nunito(
                    color: AppColors.white500,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  gregorianText,
                  style: GoogleFonts.nunito(
                    color: AppColors.green100,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
