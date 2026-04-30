import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/const/page_const.dart';
import 'package:quran_app/config/app/theme/app_colors.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_MoreItem>[
      _MoreItem(
        icon: Icons.cloud,
        title: 'Weather',
        subtitle: 'Check today\'s weather',
        route: PageConst.weatherPage,
      ),
      _MoreItem(
        icon: Icons.settings,
        title: 'Settings',
        subtitle: 'App preferences',
        route: PageConst.settingPage,
      ),
      _MoreItem(
        icon: Icons.volunteer_activism,
        title: 'Support Us',
        subtitle: 'Help keep this app free',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.black500,
      appBar: AppBar(
        backgroundColor: AppColors.green700,
        title: Text(
          'More',
          style: GoogleFonts.nunito(
            color: AppColors.white500,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) => _MoreTile(item: items[i]),
      ),
    );
  }
}

class _MoreItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? route;

  const _MoreItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.route,
  });
}

class _MoreTile extends StatelessWidget {
  final _MoreItem item;

  const _MoreTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (item.route != null) {
            Navigator.pushNamed(context, item.route!);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Coming soon')),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.green200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(item.icon, color: AppColors.green500, size: 26),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.nunito(
                        color: AppColors.white500,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.nunito(
                        color: AppColors.green100,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.grey500),
            ],
          ),
        ),
      ),
    );
  }
}
