import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/quran_reader/data/quran_meta_data.dart';
import 'package:quran_app/features/quran_reader/domain/entities/juz.dart';

class JuzIndexPage extends StatefulWidget {
  const JuzIndexPage({super.key});

  @override
  State<JuzIndexPage> createState() => _JuzIndexPageState();
}

class _JuzIndexPageState extends State<JuzIndexPage> {
  bool _searching = false;
  String _query = '';

  List<Juz> get _filtered {
    if (_query.trim().isEmpty) return QuranMeta.juzz;
    final q = _query.trim().toLowerCase();
    return QuranMeta.juzz.where((j) {
      return j.name.toLowerCase().contains(q) ||
          j.number.toString() == q;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _appBar(),
            Expanded(child: _list()),
            _continueJourneyCard(),
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
                      hintText: 'Search juzz',
                      hintStyle: GoogleFonts.nunito(
                        color: AppColors.textTertiary,
                      ),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  )
                : Text(
                    'Juzz Index',
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

  Widget _list() {
    final items = _filtered;
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No juzz matches "$_query"',
          style: GoogleFonts.nunito(color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      itemCount: items.length,
      separatorBuilder: (_, __) => Divider(
        color: AppColors.border.withValues(alpha: 0.6),
        height: 1,
      ),
      itemBuilder: (context, i) {
        final j = items[i];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _comingSoon('Juzz ${j.number}'),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${j.number}. ${j.name}',
                          style: GoogleFonts.nunito(
                            color: AppColors.gold,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Page # ${j.startPage}',
                          style: GoogleFonts.nunito(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    j.arabicOpening,
                    style: GoogleFonts.amiri(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _continueJourneyCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Continue Journey',
              style: GoogleFonts.nunito(
                color: AppColors.gold,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Resume your last recitation where you left off to maintain your daily goal.',
              style: GoogleFonts.nunito(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => _comingSoon('Quran Reader'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 7),
                    child: Text(
                      'RESUME READING',
                      style: GoogleFonts.nunito(
                        color: AppColors.textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
