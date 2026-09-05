import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/models/models.dart';

final moviesFutureProvider =
    FutureProvider.family<PaginatedResponse<Movie>, MoviesFutureProviderParams>(
      (ref, params) async {
        final movieRepository = ref.read(movieRepositoryProvider);

        final page = params.page;

        final result = await switch (params.moviesType) {
          MoviesType.trending => movieRepository.getTrendingMovies(page: page),
          MoviesType.popular => movieRepository.getPopularMovies(page: page),
          MoviesType.nowPlaying => movieRepository.getNowPlayingMovies(
            page: page,
          ),
          MoviesType.upcoming => movieRepository.getUpcomingMovies(page: page),
          MoviesType.topRated => movieRepository.getTopRatedMovies(page: page),
        };

        return result.getOrThrow();
      },
      name: 'moviesFutureProvider',
    );

class MoviesFutureProviderParams extends Equatable {
  const MoviesFutureProviderParams({
    this.page = 1,
    required this.moviesType,
  });

  final int page;
  final MoviesType moviesType;

  @override
  List<Object?> get props => [page, moviesType];
}

enum MoviesType {
  trending,
  popular,
  nowPlaying,
  upcoming,
  topRated,
}
