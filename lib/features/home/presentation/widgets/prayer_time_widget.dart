import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer_times.dart';
import 'package:quran_app/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';

class PrayerTimeWidget extends StatefulWidget {
  final VoidCallback? onTap;

  const PrayerTimeWidget({super.key, this.onTap});

  @override
  State<PrayerTimeWidget> createState() => _PrayerTimeWidgetState();
}

class _PrayerTimeWidgetState extends State<PrayerTimeWidget> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _card(),
        const SizedBox(height: 8),
        _banner(),
      ],
    );
  }

  Widget _card() {
    final now = DateTime.now();
    final hijri = HijriCalendar.fromDate(now);
    final hijriText = '${hijri.longMonthName} ${hijri.hDay}, ${hijri.hYear}';
    final gregorianText = DateFormat('EEEE, d MMM').format(now);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hijriText,
                  style: GoogleFonts.nunito(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  gregorianText,
                  style: GoogleFonts.nunito(
                    color: AppColors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
            builder: (context, state) {
              if (state is PrayerTimesLoaded) {
                final next = _nextNonSunrisePrayer(state.prayerTimes);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      next.name.english,
                      style: GoogleFonts.nunito(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _formatCountdown(next.time.difference(DateTime.now())),
                      style: GoogleFonts.robotoMono(
                        color: AppColors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined,
                  color: AppColors.textPrimary, size: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Prayer Times & Ramadan Calendar',
                  style: GoogleFonts.nunito(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textPrimary),
            ],
          ),
        ),
      ),
    );
  }

  Prayer _nextNonSunrisePrayer(PrayerTimes times) {
    final now = DateTime.now();
    for (final p in times.all) {
      if (p.name == PrayerName.sunrise) continue;
      if (p.time.isAfter(now)) return p;
    }
    return Prayer(
      name: PrayerName.fajr,
      time: times.fajr.add(const Duration(days: 1)),
    );
  }

  String _formatCountdown(Duration d) {
    if (d.isNegative) d = Duration.zero;
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.inHours)}:${two(d.inMinutes.remainder(60))}:${two(d.inSeconds.remainder(60))}';
  }
}
