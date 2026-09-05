import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/dependencies/dependencies.dart';
import 'package:movie_app/models/models.dart';

final searchMoviesFutureProvider =
    FutureProvider.family<PaginatedResponse<Movie>, String>(
      (ref, query) async {
        final trimmedQuery = query.trim();

        if (trimmedQuery.isEmpty) return const PaginatedResponse();

        final movieRepository = ref.read(movieRepositoryProvider);

        final result = await movieRepository.searchMovies(query: trimmedQuery);

        return result.getOrThrow();
      },
      name: 'searchMoviesFutureProvider',
    );
