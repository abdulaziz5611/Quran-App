import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';

class GotoPagePage extends StatefulWidget {
  const GotoPagePage({super.key});

  @override
  State<GotoPagePage> createState() => _GotoPagePageState();
}

class _GotoPagePageState extends State<GotoPagePage> {
  String _input = '';

  static const int _minPage = 2;
  static const int _maxPage = 550;

  void _addDigit(String d) {
    if (_input.length >= 3) return;
    setState(() => _input += d);
  }

  void _backspace() {
    if (_input.isEmpty) return;
    setState(() => _input = _input.substring(0, _input.length - 1));
  }

  bool get _valid {
    final n = int.tryParse(_input);
    return n != null && n >= _minPage && n <= _maxPage;
  }

  void _go() {
    if (!_valid) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Going to page $_input — Quran reader coming soon'),
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
          children: [
            _topBar(),
            _surahHint(),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _backgroundArabic(),
                  _modal(),
                ],
              ),
            ),
            _Keypad(
              onDigit: _addDigit,
              onBackspace: _backspace,
              onClose: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 8),
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
            icon:
                const Icon(Icons.workspace_premium, color: AppColors.gold),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _surahHint() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Surah Al-Kahf',
            style: GoogleFonts.nunito(
              color: AppColors.textTertiary,
              fontSize: 14,
            ),
          ),
          Text(
            'Page 293',
            style: GoogleFonts.nunito(
              color: AppColors.textTertiary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _backgroundArabic() {
    // Decorative faded Arabic to suggest the underlying Quran reader.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
            textAlign: TextAlign.center,
            style: GoogleFonts.amiri(
              color: AppColors.textTertiary.withValues(alpha: 0.4),
              fontSize: 26,
              height: 1.6,
            ),
          ),
          Text(
            'الْحَمْدُ لِلَّهِ الَّذِي أَنْزَلَ عَلَىٰ',
            textAlign: TextAlign.center,
            style: GoogleFonts.amiri(
              color: AppColors.textTertiary.withValues(alpha: 0.4),
              fontSize: 22,
              height: 1.6,
            ),
          ),
          Text(
            'الصَّالِحَاتِ أَنَّ لَهُمْ أَجْرًا حَسَنًا',
            textAlign: TextAlign.center,
            style: GoogleFonts.amiri(
              color: AppColors.textTertiary.withValues(alpha: 0.4),
              fontSize: 22,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _modal() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Go To Page',
            style: GoogleFonts.nunito(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.green, width: 1),
              ),
            ),
            child: Text(
              _input.isEmpty
                  ? 'Enter page number ($_minPage - $_maxPage)'
                  : _input,
              style: GoogleFonts.nunito(
                color: _input.isEmpty
                    ? AppColors.textTertiary
                    : AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'CANCEL',
                  style: GoogleFonts.nunito(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: _valid ? _go : null,
                child: Text(
                  'GO TO PAGE',
                  style: GoogleFonts.nunito(
                    color: _valid
                        ? AppColors.green
                        : AppColors.textTertiary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  final void Function(String) onDigit;
  final VoidCallback onClose;
  final VoidCallback onBackspace;

  const _Keypad({
    required this.onDigit,
    required this.onClose,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Column(
        children: [
          _digitRow(['1', '2', '3']),
          _digitRow(['4', '5', '6']),
          _digitRow(['7', '8', '9']),
          Row(
            children: [
              _key(
                child:
                    const Icon(Icons.close, color: AppColors.textSecondary),
                onTap: onClose,
              ),
              _key(
                child: Text('0', style: _digitStyle()),
                onTap: () => onDigit('0'),
              ),
              _key(
                child: const Icon(Icons.backspace_outlined,
                    color: AppColors.textSecondary),
                onTap: onBackspace,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _digitRow(List<String> digits) {
    return Row(
      children: digits
          .map((d) => _key(
                child: Text(d, style: _digitStyle()),
                onTap: () => onDigit(d),
              ))
          .toList(),
    );
  }

  Widget _key({required Widget child, required VoidCallback onTap}) {
    return Expanded(
      child: Material(
        color: AppColors.background,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 56,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border, width: 0.5),
                right: BorderSide(color: AppColors.border, width: 0.5),
              ),
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }

  TextStyle _digitStyle() => GoogleFonts.nunito(
        color: AppColors.textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      );
}
