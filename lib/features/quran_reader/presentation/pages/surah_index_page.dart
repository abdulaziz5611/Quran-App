import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/const/page_const.dart';
import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/quran_reader/data/quran_meta_data.dart';
import 'package:quran_app/features/quran_reader/domain/entities/surah.dart';

class SurahIndexPage extends StatefulWidget {
  const SurahIndexPage({super.key});

  @override
  State<SurahIndexPage> createState() => _SurahIndexPageState();
}

class _SurahIndexPageState extends State<SurahIndexPage> {
  static const int _recentSurahNumber = 18; // Al-Kahf
  bool _searching = false;
  String _query = '';

  List<Surah> get _filtered {
    if (_query.trim().isEmpty) return QuranMeta.surahs;
    final q = _query.trim().toLowerCase();
    return QuranMeta.surahs.where((s) {
      return s.name.toLowerCase().contains(q) ||
          s.meaning.toLowerCase().contains(q) ||
          s.number.toString() == q;
    }).toList();
  }

  void _comingSoon(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name — coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openReader(int surahNumber) {
    Navigator.pushNamed(
      context,
      PageConst.quranReaderPage,
      arguments: {'surahNumber': surahNumber},
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
            _appBar(),
            _reciterSelector(),
            Expanded(child: _list()),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.green),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: _searching
                ? TextField(
                    autofocus: true,
                    style: GoogleFonts.nunito(color: AppColors.textPrimary),
                    cursorColor: AppColors.green,
                    decoration: InputDecoration(
                      hintText: 'Search surah',
                      hintStyle: GoogleFonts.nunito(
                        color: AppColors.textTertiary,
                      ),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  )
                : Text(
                    'Surah Index',
                    style: GoogleFonts.nunito(
                      color: AppColors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
          IconButton(
            icon: Icon(
              _searching ? Icons.close : Icons.search,
              color: AppColors.green,
            ),
            onPressed: () {
              setState(() {
                _searching = !_searching;
                if (!_searching) _query = '';
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.workspace_premium, color: AppColors.gold),
            onPressed: () => _comingSoon('Premium'),
          ),
        ],
      ),
    );
  }

  Widget _reciterSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.greenTint,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withValues(alpha: 0.25),
                border: Border.all(color: AppColors.gold, width: 1.5),
              ),
              alignment: Alignment.center,
              child:
                  const Icon(Icons.workspace_premium, color: AppColors.gold, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Abdur-Rahman As-Sudais',
                    style: GoogleFonts.nunito(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Hafs an 'Asim",
                    style: GoogleFonts.nunito(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _comingSoon('Reciter selection'),
              child: Row(
                children: [
                  Text(
                    'Change',
                    style: GoogleFonts.nunito(
                      color: AppColors.green,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.green, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    final items = _filtered;
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No surah matches "$_query"',
          style: GoogleFonts.nunito(color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final s = items[i];
        return _SurahCard(
          surah: s,
          isRecent: s.number == _recentSurahNumber,
          onTap: () => _openReader(s.number),
          onPlay: () => _comingSoon('Play ${s.name}'),
          onRead: () => _openReader(s.number),
        );
      },
    );
  }
}

class _SurahCard extends StatelessWidget {
  final Surah surah;
  final bool isRecent;
  final VoidCallback onTap;
  final VoidCallback onPlay;
  final VoidCallback onRead;

  const _SurahCard({
    required this.surah,
    required this.isRecent,
    required this.onTap,
    required this.onPlay,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Text(
                      '${surah.number}',
                      style: GoogleFonts.nunito(
                        color: AppColors.gold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          surah.name,
                          style: GoogleFonts.nunito(
                            color: AppColors.gold,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${surah.meaning} • ${surah.verseCount} Verses',
                          style: GoogleFonts.nunito(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        surah.arabicName,
                        style: GoogleFonts.amiri(
                          color: AppColors.gold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      isRecent
                          ? _badge('RECENT', AppColors.gold)
                          : Text(
                              surah.type.label,
                              style: GoogleFonts.nunito(
                                color: AppColors.gold.withValues(alpha: 0.8),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _playButton(onPlay)),
                  const SizedBox(width: 10),
                  Expanded(child: _readButton(onRead)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: GoogleFonts.nunito(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _playButton(VoidCallback onTap) {
    return Material(
      color: AppColors.green,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.play_arrow, color: AppColors.textPrimary, size: 16),
              const SizedBox(width: 4),
              Text(
                'PLAY',
                style: GoogleFonts.nunito(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _readButton(VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.gold, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu_book, color: AppColors.gold, size: 14),
              const SizedBox(width: 4),
              Text(
                'READ',
                style: GoogleFonts.nunito(
                  color: AppColors.gold,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
