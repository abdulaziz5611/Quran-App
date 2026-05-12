import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:quran_app/core/config/api_config.dart';
import 'package:quran_app/core/error/exceptions.dart';
import 'package:quran_app/features/quran_reader/data/models/surah_detail_model.dart';

abstract class QuranRemoteDataSource {
  /// Fetches surah [surahNumber] from UmmahAPI. Throws [ServerException]
  /// on non-200 or invalid payload.
  Future<SurahDetailModel> getSurah(int surahNumber);
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  final http.Client client;

  QuranRemoteDataSourceImpl({required this.client});

  @override
  Future<SurahDetailModel> getSurah(int surahNumber) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/quran/surah/$surahNumber');
    final http.Response response;
    try {
      response = await client
          .get(uri, headers: ApiConfig.headers)
          .timeout(const Duration(seconds: 15));
    } catch (e) {
      throw ServerException('Network error: $e');
    }

    if (response.statusCode != 200) {
      throw ServerException(
        'Failed to fetch surah $surahNumber (HTTP ${response.statusCode})',
      );
    }

    final Map<String, dynamic> body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw ServerException('Malformed JSON response: $e');
    }

    if (body['success'] != true) {
      throw const ServerException('API returned success=false');
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const ServerException('Missing "data" field in response');
    }

    return SurahDetailModel.fromJson(data);
  }
}
