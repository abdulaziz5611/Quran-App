import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/home/presentation/widgets/date_row.dart';
import 'package:quran_app/features/home/presentation/widgets/prayer_time_component.dart';
import 'package:quran_app/features/home/presentation/widgets/salam_component.dart';
import 'package:quran_app/features/home/presentation/widgets/today_schedule.dart';
import 'package:quran_app/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:quran_app/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PrayerTimesCubit>()..load(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black500,
      appBar: AppBar(
        backgroundColor: AppColors.green700,
        title: Text(
          'Quran App',
          style: GoogleFonts.nunito(
            color: AppColors.white500,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SalamComponent(
              eng: 'Peace be upon you',
              arab: 'السَّلاَمُ عَلَيْكُمْ وَرَحْمَةُ اللهِ وَبَرَكَاتُهُ',
              subTitle: 'Continue your spiritual journey with Holy Quran',
            ),
            const SizedBox(height: 18),
            const _SectionTitle('Next Prayer'),
            const SizedBox(height: 8),
            const _NextPrayerSection(),
            const SizedBox(height: 18),
            const _SectionTitle('Today\'s Schedule'),
            const SizedBox(height: 8),
            const _TodayScheduleSection(),
            const SizedBox(height: 18),
            const DateRow(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: GoogleFonts.nunito(
          color: AppColors.white500,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _NextPrayerSection extends StatelessWidget {
  const _NextPrayerSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        if (state is PrayerTimesLoaded) {
          final next = state.nextPrayer;
          return PrayerTimeComponent(
            prayerNameEng: next.name.english,
            prayerNameArab: next.name.arabic,
            prayerTime: DateFormat.jm().format(next.time),
            iconData: Icons.access_time,
            remainingTime: _formatRemaining(next.time),
          );
        }
        if (state is PrayerTimesError) {
          return _StatusCard(child: Text(state.message));
        }
        return const _StatusCard(
          child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }

  String _formatRemaining(DateTime time) {
    final diff = time.difference(DateTime.now());
    if (diff.isNegative) return 'now';
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }
}

class _TodayScheduleSection extends StatelessWidget {
  const _TodayScheduleSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        if (state is PrayerTimesLoaded) {
          return TodayScheduleList(
            prayerTimes: state.prayerTimes,
            currentPrayer: state.prayerTimes.currentPrayer(DateTime.now()),
          );
        }
        if (state is PrayerTimesError) {
          return _StatusCard(child: Text(state.message));
        }
        return const _StatusCard(
          child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}

class _StatusCard extends StatelessWidget {
  final Widget child;
  const _StatusCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.green700,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: GoogleFonts.nunito(color: AppColors.white500),
        child: child,
      ),
    );
  }
}
