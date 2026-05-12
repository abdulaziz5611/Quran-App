import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';

class AlMubeenHeader extends StatelessWidget {
  final VoidCallback? onBellTap;
  final VoidCallback? onMenuTap;
  final bool hasUpdates;

  const AlMubeenHeader({
    super.key,
    this.onBellTap,
    this.onMenuTap,
    this.hasUpdates = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 4, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: onBellTap,
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.gold,
            ),
            visualDensity: VisualDensity.compact,
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu, color: AppColors.green),
                visualDensity: VisualDensity.compact,
              ),
              if (hasUpdates)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
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
