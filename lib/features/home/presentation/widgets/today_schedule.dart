import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer_times.dart';

class TodayScheduleList extends StatelessWidget {
  final PrayerTimes prayerTimes;
  final Prayer? currentPrayer;

  const TodayScheduleList({
    super.key,
    required this.prayerTimes,
    required this.currentPrayer,
  });

  @override
  Widget build(BuildContext context) {
    final daily = prayerTimes.all
        .where((p) => p.name != PrayerName.sunrise)
        .toList();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.green200),
      ),
      child: Column(
        children: [
          for (var i = 0; i < daily.length; i++) ...[
            _Row(
              prayer: daily[i],
              isCurrent: currentPrayer?.name == daily[i].name,
            ),
            if (i < daily.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.green200.withValues(alpha: 0.3),
              ),
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final Prayer prayer;
  final bool isCurrent;

  const _Row({required this.prayer, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrent
            ? AppColors.green700.withValues(alpha: 0.4)
            : Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(
            isCurrent ? Icons.radio_button_checked : Icons.circle_outlined,
            size: 18,
            color: isCurrent ? AppColors.green500 : AppColors.grey500,
          ),
          const SizedBox(width: 12),
          Text(
            prayer.name.english,
            style: GoogleFonts.nunito(
              color: AppColors.white500,
              fontSize: 16,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            prayer.name.arabic,
            style: GoogleFonts.nunito(
              color: AppColors.green100,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            DateFormat.jm().format(prayer.time),
            style: GoogleFonts.nunito(
              color: AppColors.white500,
              fontSize: 16,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
