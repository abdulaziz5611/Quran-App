import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/qibla_direction/presentation/widgets/qibla_dial.dart';

class QiblaFinderPage extends StatelessWidget {
  const QiblaFinderPage({super.key});

  // Kaaba.
  static const double _kaabaLat = 21.4225;
  static const double _kaabaLng = 39.8262;

  // Hardcoded user location (Ghazi, Pakistan). Swap to `geolocator` later;
  // only this block needs to change.
  static const double _userLat = 33.86;
  static const double _userLng = 72.92;
  static const String _userCity = 'Ghazi, Pakistan';
  static const int _nearbyMosques = 12;

  double get _bearing => _greatCircleBearing(_userLat, _userLng);
  double get _distanceKm => _haversineKm(_userLat, _userLng);

  String get _bearingLabel =>
      '${_bearing.toStringAsFixed(0)}° ${_cardinalOf(_bearing)} from North';

  String get _formattedDistance {
    final km = _distanceKm.round();
    final formatted = km.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '$formatted km';
  }

  void _comingSoon(BuildContext context, String name) {
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
            _appBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    QiblaDial(bearingDegrees: _bearing),
                    const SizedBox(height: 24),
                    Text(
                      _bearingLabel,
                      style: GoogleFonts.nunito(
                        color: AppColors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'CALIBRATION: HIGH ACCURACY',
                      style: GoogleFonts.nunito(
                        color: AppColors.green.withValues(alpha: 0.7),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 22),
                    _cityCard(context),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            icon: Icons.mosque,
                            iconColor: AppColors.gold,
                            value: '$_nearbyMosques',
                            label: 'Nearby Mosques',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _statCard(
                            icon: Icons.location_on,
                            iconColor: AppColors.green,
                            value: _formattedDistance,
                            label: 'Distance to Makkah',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _viewMapButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 12, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.green),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Qibla Finder',
            style: GoogleFonts.nunito(
              color: AppColors.green,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.explore_outlined, color: AppColors.green),
            onPressed: () => _comingSoon(context, 'Recalibrate'),
          ),
        ],
      ),
    );
  }

  Widget _cityCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.green.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.location_on,
                color: AppColors.green, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current City',
                  style: GoogleFonts.nunito(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _userCity,
                  style: GoogleFonts.nunito(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _comingSoon(context, 'Change city'),
            child: Text(
              'CHANGE',
              style: GoogleFonts.nunito(
                color: AppColors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.nunito(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.nunito(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewMapButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () => _comingSoon(context, 'Mosque map'),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.map_outlined,
                    color: AppColors.textPrimary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'VIEW MOSQUE MAP',
                  style: GoogleFonts.nunito(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Geometry ────────────────────────────────────────────────────────────

  static double _greatCircleBearing(double lat, double lng) {
    final phi1 = _toRad(lat);
    final phi2 = _toRad(_kaabaLat);
    final dLambda = _toRad(_kaabaLng - lng);
    final y = math.sin(dLambda) * math.cos(phi2);
    final x = math.cos(phi1) * math.sin(phi2) -
        math.sin(phi1) * math.cos(phi2) * math.cos(dLambda);
    final theta = math.atan2(y, x);
    return (_toDeg(theta) + 360) % 360;
  }

  static double _haversineKm(double lat, double lng) {
    const earthKm = 6371.0;
    final phi1 = _toRad(lat);
    final phi2 = _toRad(_kaabaLat);
    final dPhi = _toRad(_kaabaLat - lat);
    final dLambda = _toRad(_kaabaLng - lng);
    final a = math.sin(dPhi / 2) * math.sin(dPhi / 2) +
        math.cos(phi1) *
            math.cos(phi2) *
            math.sin(dLambda / 2) *
            math.sin(dLambda / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthKm * c;
  }

  static String _cardinalOf(double bearing) {
    if (bearing < 22.5 || bearing >= 337.5) return 'N';
    if (bearing < 67.5) return 'NE';
    if (bearing < 112.5) return 'E';
    if (bearing < 157.5) return 'SE';
    if (bearing < 202.5) return 'S';
    if (bearing < 247.5) return 'SW';
    if (bearing < 292.5) return 'W';
    return 'NW';
  }

  static double _toRad(double deg) => deg * math.pi / 180;
  static double _toDeg(double rad) => rad * 180 / math.pi;
}
