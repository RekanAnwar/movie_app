import 'package:dio/dio.dart';
import 'package:movie_app/mappers/mappers.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class GenreRepository {
  const GenreRepository(this._dio);

  final Dio _dio;

  Future<Result<List<Genre>>> getGenres() => makeApiCall(
    () async {
      final response = await _dio.get('genre/movie/list');

      final responseData = response.data as Map<String, dynamic>;
      final genres = responseData['genres'] as List<dynamic>;

      return genres
          .map((e) => GenreMapper.fromJson(e as Map<String, dynamic>))
          .whereType<Genre>()
          .toList();
    },
    defaultErrorMessage: 'Failed to load genres',
  );
}
