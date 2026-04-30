import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/more/more_page.dart';
import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/home/presentation/pages/home_page.dart';
import 'package:quran_app/features/listen_quran/presentation/pages/main_quran_page.dart';
import 'package:quran_app/features/qibla_direction/presentation/pages/main_qibla_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  static const _pages = <Widget>[
    HomePage(),
    MainQuranPage(),
    MainQiblaPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.black500,
      selectedItemColor: AppColors.green500,
      unselectedItemColor: AppColors.grey500,
      selectedFontSize: 12,
      unselectedFontSize: 11,
      selectedLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.bold),
      unselectedLabelStyle: GoogleFonts.nunito(),
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          activeIcon: Icon(Icons.menu_book),
          label: 'Quran',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore),
          label: 'Qibla',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_outlined),
          activeIcon: Icon(Icons.grid_view),
          label: 'More',
        ),
      ],
    );
  }
}
