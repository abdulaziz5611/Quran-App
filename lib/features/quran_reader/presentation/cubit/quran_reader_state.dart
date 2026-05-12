part of 'quran_reader_cubit.dart';

abstract class QuranReaderState extends Equatable {
  const QuranReaderState();

  @override
  List<Object?> get props => [];
}

class QuranReaderInitial extends QuranReaderState {
  const QuranReaderInitial();
}

class QuranReaderLoading extends QuranReaderState {
  const QuranReaderLoading();
}

class QuranReaderLoaded extends QuranReaderState {
  final SurahDetail surah;

  const QuranReaderLoaded(this.surah);

  @override
  List<Object?> get props => [surah];
}

class QuranReaderError extends QuranReaderState {
  final String message;

  const QuranReaderError(this.message);

  @override
  List<Object?> get props => [message];
}
