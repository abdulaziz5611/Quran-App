import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/core/usecase/usecase.dart';
import 'package:quran_app/features/quran_reader/domain/entities/surah_detail.dart';
import 'package:quran_app/features/quran_reader/domain/repositories/quran_repository.dart';

class GetSurahDetail implements UseCase<SurahDetail, GetSurahParams> {
  final QuranRepository repository;

  const GetSurahDetail(this.repository);

  @override
  Future<Either<Failure, SurahDetail>> call(GetSurahParams params) {
    return repository.getSurahDetail(params.surahNumber);
  }
}

class GetSurahParams extends Equatable {
  final int surahNumber;

  const GetSurahParams({required this.surahNumber});

  @override
  List<Object?> get props => [surahNumber];
}
