import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/repositories/repositories.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main',
  ),
  name: 'sharedPreferencesProvider',
);

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        headers: {'Authorization': 'Bearer ${Env.accessToken}'},
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printResponseTime: true,
            printRequestHeaders: true,
          ),
        ),
      );
    }

    return dio;
  },
  name: 'dioProvider',
);

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepository(ref.read(dioProvider)),
  name: 'movieRepositoryProvider',
);

final genreRepositoryProvider = Provider<GenreRepository>(
  (ref) => GenreRepository(ref.read(dioProvider)),
  name: 'genreRepositoryProvider',
);

final watchlistRepositoryProvider = Provider<WatchlistRepository>(
  (ref) => WatchlistRepository(ref.read(sharedPreferencesProvider)),
  name: 'watchlistRepositoryProvider',
);
