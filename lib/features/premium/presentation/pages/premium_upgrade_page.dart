import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';

enum _Plan { yearly, monthly }

class PremiumUpgradePage extends StatefulWidget {
  const PremiumUpgradePage({super.key});

  @override
  State<PremiumUpgradePage> createState() => _PremiumUpgradePageState();
}

class _PremiumUpgradePageState extends State<PremiumUpgradePage> {
  _Plan _selected = _Plan.yearly;

  void _comingSoon(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name — coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String get _planLabel => _selected == _Plan.yearly
      ? 'Yearly (\$49.99/yr)'
      : 'Monthly (\$5.99/mo)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(),
            const Divider(color: AppColors.border, height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _hero(),
                    const SizedBox(height: 20),
                    _sectionLabel('Exclusive Benefits'),
                    const SizedBox(height: 10),
                    _benefitsGrid(),
                    const SizedBox(height: 18),
                    _upgradeButton(),
                    const SizedBox(height: 14),
                    _planCard(
                      plan: _Plan.yearly,
                      title: 'Yearly Access',
                      subtitle: 'Best spiritual investment',
                      price: '\$49.99/yr',
                      badge: 'SAVE 31%',
                    ),
                    const SizedBox(height: 10),
                    _planCard(
                      plan: _Plan.monthly,
                      title: 'Monthly Access',
                      subtitle: 'Flexible commitment',
                      price: '\$5.99/mo',
                    ),
                    const SizedBox(height: 18),
                    _termsText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.green),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Premium Upgrade',
            style: GoogleFonts.nunito(
              color: AppColors.green,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.help_outline, color: AppColors.green),
            onPressed: () => _comingSoon('Help'),
          ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE5503D), Color(0xFFF5A623)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.textPrimary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'AL-MUBEEN EXCLUSIVE',
              style: GoogleFonts.nunito(
                color: AppColors.textPrimary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Unlock Spiritual\nExcellence',
            style: GoogleFonts.nunito(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Deepen your connection with our\npremium suite of tools.',
            style: GoogleFonts.nunito(
              color: AppColors.textPrimary.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: GoogleFonts.nunito(
          color: AppColors.gold,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _benefitsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _benefitCard(
                icon: Icons.block,
                title: 'Ad-free Experience',
                description: 'Focus purely on your worship',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _benefitCard(
                icon: Icons.record_voice_over,
                title: 'Exclusive Reciters',
                description: 'High-fidelity world-class voices',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _benefitCard(
                icon: Icons.notifications_active_outlined,
                title: 'Premium Athan',
                description: 'Global majestic prayer calls',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _benefitCard(
                icon: Icons.download_outlined,
                title: 'Offline Audio',
                description: 'Download and listen anywhere',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _benefitCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: AppColors.gold, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: AppColors.textPrimary,
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: AppColors.textSecondary,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _upgradeButton() {
    return Material(
      color: AppColors.green,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () => _comingSoon('$_planLabel upgrade'),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: AppColors.textPrimary, size: 16),
              const SizedBox(width: 8),
              Text(
                'UPGRADE NOW',
                style: GoogleFonts.nunito(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _planCard({
    required _Plan plan,
    required String title,
    required String subtitle,
    required String price,
    String? badge,
  }) {
    final isSelected = _selected == plan;
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => _selected = plan),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.green : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              _radio(isSelected),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.nunito(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.nunito(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (badge != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.green.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        badge,
                        style: GoogleFonts.nunito(
                          color: AppColors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    price,
                    style: GoogleFonts.nunito(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radio(bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.green : AppColors.textTertiary,
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.green,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }

  Widget _termsText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'By upgrading, you agree to our Terms of Service and Privacy Policy. Subscriptions automatically renew unless cancelled 24h before the end of the period.',
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          color: AppColors.textTertiary,
          fontSize: 11,
          height: 1.5,
        ),
      ),
    );
  }
}
