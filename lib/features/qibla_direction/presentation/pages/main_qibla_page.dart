import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/config/app/theme/app_colors.dart';
import 'package:quran_app/features/qibla_direction/presentation/cubit/qibla_cubit.dart';
import 'package:quran_app/features/qibla_direction/presentation/widgets/qibla_compass.dart';
import 'package:quran_app/injection_container.dart';

class MainQiblaPage extends StatelessWidget {
  const MainQiblaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QiblaCubit>()..load(),
      child: const _QiblaView(),
    );
  }
}

class _QiblaView extends StatelessWidget {
  const _QiblaView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black500,
      appBar: AppBar(
        backgroundColor: AppColors.green700,
        title: Text(
          'Qibla',
          style: GoogleFonts.nunito(
            color: AppColors.white500,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.white500),
      ),
      body: BlocBuilder<QiblaCubit, QiblaState>(
        builder: (context, state) {
          if (state is QiblaLoaded) {
            final bearing = state.direction.bearingFromNorth;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QiblaCompass(bearingDegrees: bearing),
                  const SizedBox(height: 32),
                  Text(
                    '${bearing.toStringAsFixed(1)}° from North',
                    style: GoogleFonts.nunito(
                      color: AppColors.white500,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Align the top of your device with North,\nthen face the green arrow.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: AppColors.green100,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is QiblaError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(color: AppColors.white500),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
