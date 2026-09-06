import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/models/models.dart';

final searchMoviesFutureProvider =
    FutureProvider.family<
      PaginatedResponse<Movie>,
      SearchMoviesFutureProviderParams
    >(
      (ref, params) async {
        final trimmedQuery = params.query.trim();

        if (trimmedQuery.isEmpty) return const PaginatedResponse();

        final movieRepository = ref.read(movieRepositoryProvider);

        final result = await movieRepository.searchMovies(
          query: trimmedQuery,
          page: params.page,
        );

        return result.getOrThrow();
      },
      name: 'searchMoviesFutureProvider',
    );

class SearchMoviesFutureProviderParams extends Equatable {
  const SearchMoviesFutureProviderParams({
    required this.query,
    this.page = 1,
  });

  final String query;
  final int page;

  @override
  List<Object?> get props => [query, page];
}
