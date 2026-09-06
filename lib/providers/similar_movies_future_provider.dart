import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/models/models.dart';

final similarMoviesFutureProvider =
    FutureProvider.family<
      PaginatedResponse<Movie>,
      SimilarMoviesFutureProviderParams
    >(
      (ref, params) async {
        final movieRepository = ref.read(movieRepositoryProvider);

        final result = await movieRepository.getSimilarMovies(
          id: params.movieId,
          page: params.page,
        );

        return result.getOrThrow();
      },
      name: 'similarMoviesFutureProvider',
    );

class SimilarMoviesFutureProviderParams extends Equatable {
  const SimilarMoviesFutureProviderParams({
    required this.movieId,
    this.page = 1,
  });

  final int movieId;
  final int page;

  @override
  List<Object?> get props => [movieId, page];
}
