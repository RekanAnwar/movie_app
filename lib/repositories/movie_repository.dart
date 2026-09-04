import 'package:dio/dio.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/mappers/mappers.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class MovieRepository {
  const MovieRepository(this._dio);

  final Dio _dio;

  Future<Result<PaginatedResponse<Movie>>> getTrendingMovies({
    required int page,
  }) => makeApiCall(
    () async {
      final response = await _dio.get(
        '${Urls.baseUrl}trending/movie/week',
        queryParameters: {
          // HACK: add api key here
          'api_key': '',
          'page': page,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      final currentPage = responseData['page'] as int;
      final totalPages = responseData['total_pages'] as int;
      final totalResults = responseData['total_results'] as int;
      final results = responseData['results'] as List<dynamic>;

      final data = results.map((e) => MovieMapper.fromJson(e)).toList();

      return PaginatedResponse<Movie>(
        data: data,
        page: currentPage,
        totalPages: totalPages,
        totalResults: totalResults,
      );
    },
    defaultErrorMessage: 'Failed to load trending movies',
  );

  Future<Result<Movie>> getMovieDetails({
    required int id,
  }) => makeApiCall(
    () async {
      final response = await _dio.get(
        '${Urls.baseUrl}movie/$id',
        // HACK: add api key here
        queryParameters: {
          'api_key': '',
          'append_to_response': 'similar',
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      return MovieMapper.fromJson(responseData);
    },
    defaultErrorMessage: 'Failed to load movie',
  );
}
