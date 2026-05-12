import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/exceptions.dart';
import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/features/quran_reader/data/datasources/quran_remote_data_source.dart';
import 'package:quran_app/features/quran_reader/domain/entities/surah_detail.dart';
import 'package:quran_app/features/quran_reader/domain/repositories/quran_repository.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;

  const QuranRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SurahDetail>> getSurahDetail(int surahNumber) async {
    try {
      final surah = await remoteDataSource.getSurah(surahNumber);
      return Right(surah);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
