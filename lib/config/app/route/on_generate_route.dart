import 'package:flutter/material.dart';

import 'package:quran_app/config/app/const/page_const.dart';
import 'package:quran_app/config/app/splash/splash_page.dart';
import 'package:quran_app/features/bookmarks/presentation/pages/bookmarks_page.dart';
import 'package:quran_app/features/home/presentation/pages/home_page.dart';
import 'package:quran_app/features/premium/presentation/pages/premium_upgrade_page.dart';
import 'package:quran_app/features/qibla_direction/presentation/pages/qibla_finder_page.dart';
import 'package:quran_app/features/quran_reader/presentation/pages/goto_page_page.dart';
import 'package:quran_app/features/quran_reader/presentation/pages/juz_index_page.dart';
import 'package:quran_app/features/quran_reader/presentation/pages/quran_reader_page.dart';
import 'package:quran_app/features/quran_reader/presentation/pages/surah_index_page.dart';
import 'package:quran_app/features/settings/presentation/pages/quran_scripts_page.dart';
import 'package:quran_app/features/settings/presentation/pages/settings_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.splashPage:
        return _builder(const SplashPage());
      case PageConst.homePage:
        return _builder(const HomePage());
      case PageConst.settingsPage:
        return _builder(const SettingsPage());
      case PageConst.quranScriptsPage:
        return _builder(const QuranScriptsPage());
      case PageConst.gotoPage:
        return _builder(const GotoPagePage());
      case PageConst.premiumPage:
        return _builder(const PremiumUpgradePage());
      case PageConst.surahIndexPage:
        return _builder(const SurahIndexPage());
      case PageConst.juzIndexPage:
        return _builder(const JuzIndexPage());
      case PageConst.bookmarksPage:
        return _builder(const BookmarksPage());
      case PageConst.qiblaPage:
        return _builder(const QiblaFinderPage());
      case PageConst.quranReaderPage:
        final args = settings.arguments as Map<String, dynamic>?;
        final surahNumber = (args?['surahNumber'] as int?) ?? 1;
        return _builder(QuranReaderPage(surahNumber: surahNumber));
      default:
        return _builder(const _NotFoundPage());
    }
  }

  static MaterialPageRoute _builder(Widget page) =>
      MaterialPageRoute(builder: (_) => page);
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: const Center(child: Text('Page not found')),
    );
  }
}
