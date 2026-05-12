import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quran_app/features/quran_reader/domain/entities/surah_detail.dart';
import 'package:quran_app/features/quran_reader/domain/usecases/get_surah_detail.dart';

part 'quran_reader_state.dart';

class QuranReaderCubit extends Cubit<QuranReaderState> {
  final GetSurahDetail getSurahDetail;

  QuranReaderCubit({required this.getSurahDetail})
      : super(const QuranReaderInitial());

  Future<void> load(int surahNumber) async {
    emit(const QuranReaderLoading());
    final result =
        await getSurahDetail(GetSurahParams(surahNumber: surahNumber));
    result.fold(
      (failure) => emit(QuranReaderError(failure.message)),
      (surah) => emit(QuranReaderLoaded(surah)),
    );
  }
}
