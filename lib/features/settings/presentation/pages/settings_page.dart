import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/const/page_const.dart';
import 'package:quran_app/config/app/theme/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _fontSize = 24;
  bool _vibrate = true;
  bool _verticalReading = false;

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(),
              const SizedBox(height: 8),
              _premiumBanner(),
              const SizedBox(height: 22),
              _fontStyleSection(),
              const SizedBox(height: 22),
              _generalSection(),
              const SizedBox(height: 22),
              _toolsSection(),
              const SizedBox(height: 22),
              _otherSection(),
              const SizedBox(height: 32),
              _footer(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.green),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Settings',
            style: GoogleFonts.nunito(
              color: AppColors.green,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon:
                const Icon(Icons.workspace_premium, color: AppColors.gold),
            onPressed: () =>
                Navigator.pushNamed(context, PageConst.premiumPage),
          ),
        ],
      ),
    );
  }

  Widget _premiumBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFA8341C), Color(0xFFE08F39)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium,
                  color: AppColors.gold, size: 16),
              const SizedBox(width: 6),
              Text(
                'PREMIUM ACCESS',
                style: GoogleFonts.nunito(
                  color: AppColors.gold,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Unlock Spiritual Excellence',
            style: GoogleFonts.nunito(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Remove ads, unlock exclusive reciters, and support the spread of the message.',
            style: GoogleFonts.nunito(
              color: AppColors.textPrimary.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () =>
                    Navigator.pushNamed(context, PageConst.premiumPage),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 9),
                  child: Text(
                    'UPGRADE NOW',
                    style: GoogleFonts.nunito(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.nunito(
              color: AppColors.gold,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fontStyleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(Icons.text_fields, 'Font Style'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _scriptTile(),
              const SizedBox(height: 8),
              _fontSizeTile(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scriptTile() {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () =>
            Navigator.pushNamed(context, PageConst.quranScriptsPage),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arabic Script',
                      style: GoogleFonts.nunito(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Uthmani Script (Default)',
                      style: GoogleFonts.nunito(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: AppColors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fontSizeTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Font Size',
                style: GoogleFonts.nunito(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${_fontSize.toInt()}px',
                style: GoogleFonts.nunito(
                  color: AppColors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('A',
                  style: GoogleFonts.nunito(
                      color: AppColors.textSecondary, fontSize: 12)),
              Text('A',
                  style: GoogleFonts.nunito(
                      color: AppColors.textSecondary, fontSize: 16)),
              Text('A',
                  style: GoogleFonts.nunito(
                      color: AppColors.textSecondary, fontSize: 20)),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              activeTrackColor: AppColors.green,
              inactiveTrackColor: AppColors.border,
              thumbColor: AppColors.green,
              overlayColor: AppColors.green.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: _fontSize,
              min: 14,
              max: 32,
              onChanged: (v) => setState(() => _fontSize = v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _generalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(Icons.settings_outlined, 'General'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _toggleTile(
                icon: Icons.vibration,
                title: 'Vibrate on Prayer Time',
                value: _vibrate,
                onChanged: (v) => setState(() => _vibrate = v),
              ),
              const SizedBox(height: 8),
              _toggleTile(
                icon: Icons.swap_vert,
                title: 'Vertical Reading Mode',
                value: _verticalReading,
                onChanged: (v) => setState(() => _verticalReading = v),
              ),
              const SizedBox(height: 8),
              _valueTile(
                icon: Icons.language,
                title: 'App Language',
                value: 'English',
                onTap: () => _comingSoon('Language picker'),
              ),
              const SizedBox(height: 8),
              _valueTile(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                value: 'Dark Mode',
                onTap: () => _comingSoon('Theme picker'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toggleTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 18),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.nunito(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? AppColors.textPrimary
                  : AppColors.textSecondary;
            }),
            trackColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? AppColors.green
                  : AppColors.border;
            }),
            trackOutlineColor:
                WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }

  Widget _valueTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: AppColors.gold, size: 18),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.nunito(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.nunito(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right,
                  color: AppColors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toolsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(Icons.handyman_outlined, 'Tools'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _valueTile(
            icon: Icons.explore_outlined,
            title: 'Qibla Finder',
            value: 'Compass',
            onTap: () =>
                Navigator.pushNamed(context, PageConst.qiblaPage),
          ),
        ),
      ],
    );
  }

  Widget _otherSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(Icons.info_outline, 'Other'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _linkTile(
                icon: Icons.star_outline,
                title: 'Rate Us',
                trailing: Icons.open_in_new,
                onTap: () => _comingSoon('Rate Us'),
              ),
              const SizedBox(height: 8),
              _linkTile(
                icon: Icons.share_outlined,
                title: 'Share with Friends',
                trailing: Icons.chevron_right,
                onTap: () => _comingSoon('Share'),
              ),
              const SizedBox(height: 8),
              _linkTile(
                icon: Icons.shield_outlined,
                title: 'Privacy Policy',
                trailing: Icons.chevron_right,
                onTap: () => _comingSoon('Privacy Policy'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _linkTile({
    required IconData icon,
    required String title,
    required IconData trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: AppColors.gold, size: 18),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.nunito(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(trailing, color: AppColors.textSecondary, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child:
                const Icon(Icons.menu_book, color: AppColors.gold, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Al-Mubeen App',
            style: GoogleFonts.nunito(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Version 4.2.0 (Build 2024)',
            style: GoogleFonts.nunito(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Made with devotion for the Ummah. May Allah bless your journey.',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: AppColors.textTertiary,
              fontSize: 11,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
