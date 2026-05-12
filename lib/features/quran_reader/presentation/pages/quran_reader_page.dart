import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/quran_reader/data/quran_meta_data.dart';
import 'package:quran_app/features/quran_reader/domain/entities/juz.dart';
import 'package:quran_app/features/quran_reader/domain/entities/surah.dart';
import 'package:quran_app/features/quran_reader/domain/entities/verse.dart';
import 'package:quran_app/features/quran_reader/presentation/cubit/quran_reader_cubit.dart';
import 'package:quran_app/injection_container.dart';

class QuranReaderPage extends StatelessWidget {
  final int surahNumber;

  const QuranReaderPage({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QuranReaderCubit>()..load(surahNumber),
      child: _QuranReaderView(surahNumber: surahNumber),
    );
  }
}

class _QuranReaderView extends StatelessWidget {
  final int surahNumber;

  const _QuranReaderView({required this.surahNumber});

  Surah get _meta => QuranMeta.surahs[surahNumber - 1];

  int get _juzNumber {
    Juz? containing;
    for (final j in QuranMeta.juzz) {
      if (j.startPage <= _meta.startPage) {
        containing = j;
      } else {
        break;
      }
    }
    return containing?.number ?? 1;
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _appBar(context),
            const Divider(color: AppColors.border, height: 1),
            Expanded(
              child: BlocBuilder<QuranReaderCubit, QuranReaderState>(
                builder: (context, state) {
                  if (state is QuranReaderLoaded) {
                    return _verseList(state);
                  }
                  if (state is QuranReaderError) {
                    return _errorView(context, state);
                  }
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.green),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.green),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _meta.name,
                  style: GoogleFonts.nunito(
                    color: AppColors.green,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Juzz $_juzNumber • Page ${_meta.startPage}',
                  style: GoogleFonts.nunito(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: AppColors.gold),
            onPressed: () => _comingSoon(context, 'Bookmark this page'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.green),
            onPressed: () => _comingSoon(context, 'Reader settings'),
          ),
        ],
      ),
    );
  }

  Widget _verseList(QuranReaderLoaded state) {
    final surah = state.surah;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: surah.verses.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) return _surahHeader(surah.nameArabic, surah.nameEnglish);
        return _verseCard(surah.verses[i - 1]);
      },
    );
  }

  Widget _surahHeader(String arabic, String english) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.greenTint,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.green.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            arabic,
            textAlign: TextAlign.center,
            style: GoogleFonts.amiri(
              color: AppColors.gold,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            english,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
            textAlign: TextAlign.center,
            style: GoogleFonts.amiri(
              color: AppColors.textPrimary,
              fontSize: 22,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verseCard(Verse v) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${v.ayah}',
                  style: GoogleFonts.nunito(
                    color: AppColors.gold,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 14),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              v.arabic,
              textAlign: TextAlign.right,
              style: GoogleFonts.amiri(
                color: AppColors.textPrimary,
                fontSize: 24,
                height: 1.9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (v.transliteration.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              v.transliteration,
              style: GoogleFonts.nunito(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ],
          if (v.translation.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              v.translation,
              style: GoogleFonts.nunito(
                color: AppColors.textPrimary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _errorView(BuildContext context, QuranReaderError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, color: AppColors.danger, size: 40),
            const SizedBox(height: 12),
            Text(
              'Could not load surah',
              style: GoogleFonts.nunito(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () =>
                  context.read<QuranReaderCubit>().load(surahNumber),
              child: Text(
                'TRY AGAIN',
                style: GoogleFonts.nunito(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
