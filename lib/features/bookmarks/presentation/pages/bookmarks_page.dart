import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/bookmarks/domain/entities/bookmark.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  // Sample data. Persistence (shared_preferences / hive) will replace this
  // once a BookmarksRepository is introduced.
  final List<Bookmark> _bookmarks = const [
    Bookmark(surahName: 'Al-Baqarah', page: 2),
    Bookmark(surahName: 'Al-Kahf', page: 293),
    Bookmark(surahName: 'Maryam', page: 305),
    Bookmark(surahName: 'Ya-Sin', page: 440),
    Bookmark(surahName: 'Al-Mulk', page: 562),
    Bookmark(surahName: 'Ar-Rahman', page: 531),
    Bookmark(surahName: 'An-Naba', page: 582),
    Bookmark(surahName: 'Al-Ikhlas', page: 604),
  ];

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
            _libraryHeader(),
            Expanded(child: _bookmarks.isEmpty ? _emptyState() : _list()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        onPressed: () => _comingSoon('Add bookmark'),
        child: const Icon(Icons.add, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.green),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Al-Mubeen',
            style: GoogleFonts.nunito(
              color: AppColors.green,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.workspace_premium, color: AppColors.gold),
            onPressed: () => _comingSoon('Premium'),
          ),
        ],
      ),
    );
  }

  Widget _libraryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Library',
            style: GoogleFonts.nunito(
              color: AppColors.gold,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Bookmarks',
                style: GoogleFonts.nunito(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '${_bookmarks.length} Items',
                  style: GoogleFonts.nunito(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
      itemCount: _bookmarks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final b = _bookmarks[i];
        return Material(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _comingSoon('Open ${b.surahName}'),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _comingSoon('Play ${b.surahName}'),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: AppColors.green,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.play_arrow,
                        color: AppColors.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b.surahName,
                          style: GoogleFonts.nunito(
                            color: AppColors.gold,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Page ${b.page}',
                          style: GoogleFonts.nunito(
                            color: AppColors.green,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.bookmark,
                      color: AppColors.gold, size: 22),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.border,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.menu_book,
              color: AppColors.gold.withValues(alpha: 0.5),
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No bookmarks yet',
            style: GoogleFonts.nunito(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap + to add your first one',
            style: GoogleFonts.nunito(
              color: AppColors.textTertiary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
