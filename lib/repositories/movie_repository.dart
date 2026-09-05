import 'package:dio/dio.dart';
import 'package:movie_app/mappers/mappers.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/utils/utils.dart';

class MovieRepository {
  const MovieRepository(this._dio);

  final Dio _dio;

  Future<Result<PaginatedResponse<Movie>>> getTrendingMovies({
    int page = 1,
  }) => _getMovies(
    path: 'trending/movie/day',
    queryParameters: {'page': page},
    defaultErrorMessage: 'Failed to load trending movies',
  );

  Future<Result<PaginatedResponse<Movie>>> getPopularMovies({
    int page = 1,
  }) => _getMovies(
    path: 'movie/popular',
    queryParameters: {'page': page},
    defaultErrorMessage: 'Failed to load popular movies',
  );

  Future<Result<PaginatedResponse<Movie>>> getNowPlayingMovies({
    int page = 1,
  }) => _getMovies(
    path: 'movie/now_playing',
    queryParameters: {'page': page},
    defaultErrorMessage: 'Failed to load now playing movies',
  );

  Future<Result<PaginatedResponse<Movie>>> getUpcomingMovies({
    int page = 1,
  }) => _getMovies(
    path: 'movie/upcoming',
    queryParameters: {'page': page},
    defaultErrorMessage: 'Failed to load upcoming movies',
  );

  Future<Result<PaginatedResponse<Movie>>> getTopRatedMovies({
    int page = 1,
  }) => _getMovies(
    path: 'movie/top_rated',
    queryParameters: {'page': page},
    defaultErrorMessage: 'Failed to load top rated movies',
  );

  Future<Result<PaginatedResponse<Movie>>> searchMovies({
    required String query,
    int page = 1,
    // HACK: check this parameter
    bool includeAdult = false,
  }) => _getMovies(
    path: 'search/movie',
    queryParameters: {
      'query': query,
      'page': page,
      'include_adult': includeAdult,
    },
    defaultErrorMessage: 'Failed to search movies',
  );

  Future<Result<Movie>> getMovieDetails({required int id}) => makeApiCall(
    () async {
      final response = await _dio.get(
        'movie/$id',
        queryParameters: {'append_to_response': 'similar'},
      );

      final responseData = response.data as Map<String, dynamic>;

      return MovieMapper.fromJson(responseData);
    },
    defaultErrorMessage: 'Failed to load movie',
  );

  Future<Result<PaginatedResponse<Movie>>> _getMovies({
    required String path,
    required Map<String, dynamic> queryParameters,
    required String defaultErrorMessage,
  }) => makeApiCall(
    () async {
      final response = await _dio.get(
        path,
        queryParameters: {
          ...queryParameters,
        },
      );

      final responseData = response.data as Map<String, dynamic>;

      final currentPage = responseData['page'] as int;
      final totalPages = responseData['total_pages'] as int;
      final totalResults = responseData['total_results'] as int;
      final results = responseData['results'] as List<dynamic>;

      final data = results
          .map((e) => MovieMapper.fromJson(e as Map<String, dynamic>))
          .toList();

      return PaginatedResponse<Movie>(
        data: data,
        page: currentPage,
        totalPages: totalPages,
        totalResults: totalResults,
      );
    },
    defaultErrorMessage: defaultErrorMessage,
  );
}
