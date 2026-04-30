import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quran_app/core/usecase/usecase.dart';
import 'package:quran_app/features/qibla_direction/domain/entities/qibla_direction.dart';
import 'package:quran_app/features/qibla_direction/domain/usecases/get_qibla_direction.dart';

part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  final GetQiblaDirection getQiblaDirection;

  QiblaCubit({required this.getQiblaDirection}) : super(const QiblaInitial());

  Future<void> load() async {
    emit(const QiblaLoading());
    final result = await getQiblaDirection(const NoParams());
    result.fold(
      (failure) => emit(QiblaError(failure.message)),
      (direction) => emit(QiblaLoaded(direction)),
    );
  }
}
