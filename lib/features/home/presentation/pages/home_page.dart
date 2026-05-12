import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quran_app/config/app/const/page_const.dart';
import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/home/presentation/widgets/action_tile.dart';
import 'package:quran_app/features/home/presentation/widgets/al_mubeen_header.dart';
import 'package:quran_app/features/home/presentation/widgets/greeting_row.dart';
import 'package:quran_app/features/home/presentation/widgets/prayer_time_widget.dart';
import 'package:quran_app/features/home/presentation/widgets/quote_widget.dart';
import 'package:quran_app/features/home/presentation/widgets/resume_reading_card.dart';
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

  void _comingSoon(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name — coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AlMubeenHeader(
                onBellTap: () => _comingSoon(context, 'Notifications'),
                onMenuTap: () => Navigator.pushNamed(
                  context,
                  PageConst.settingsPage,
                ),
                hasUpdates: true,
              ),
              const GreetingRow(name: 'Abdullah', ayahsToday: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    PrayerTimeWidget(
                      onTap: () => _comingSoon(context, 'Prayer Times'),
                    ),
                    const SizedBox(height: 14),
                    ResumeReadingCard(
                      onTap: () => Navigator.pushNamed(
                        context,
                        PageConst.quranReaderPage,
                        arguments: const {'surahNumber': 1},
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ActionGrid(
                      onComingSoon: (n) => _comingSoon(context, n),
                    ),
                  ],
                ),
              ),
              const QuoteWidget(text: 'Verily, with hardship comes ease.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  final void Function(String) onComingSoon;

  const _ActionGrid({required this.onComingSoon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ActionTile(
                icon: Icons.format_list_bulleted,
                label: 'Juzz Index',
                onTap: () =>
                    Navigator.pushNamed(context, PageConst.juzIndexPage),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ActionTile(
                icon: Icons.format_list_numbered,
                label: 'Surah Index',
                onTap: () =>
                    Navigator.pushNamed(context, PageConst.surahIndexPage),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ActionTile(
                icon: Icons.menu_book,
                label: 'Goto Page',
                onTap: () =>
                    Navigator.pushNamed(context, PageConst.gotoPage),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ActionTile(
                icon: Icons.bookmark,
                label: 'Bookmarks',
                onTap: () =>
                    Navigator.pushNamed(context, PageConst.bookmarksPage),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
