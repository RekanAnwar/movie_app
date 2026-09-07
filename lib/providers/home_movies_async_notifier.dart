import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_future_provider.dart';

final homeMoviesAsyncNotifierProvider =
    AsyncNotifierProvider<HomeMoviesNotifier, List<PaginatedResponse<Movie>>>(
      HomeMoviesNotifier.new,
      name: 'homeMoviesAsyncNotifierProvider',
    );

class HomeMoviesNotifier extends AsyncNotifier<List<PaginatedResponse<Movie>>> {
  @override
  Future<List<PaginatedResponse<Movie>>> build() async {
    final results = <PaginatedResponse<Movie>>[];
    Object? firstError;

    for (final moviesType in MoviesType.values) {
      if (state.value == null || state.hasError) state = const AsyncLoading();

      try {
        final value = await ref.watch(
          moviesFutureProvider(
            MoviesFutureProviderParams(moviesType: moviesType),
          ).future,
        );

        results.add(value);
      } catch (error) {
        firstError ??= error;
      }
    }

    if (results.any((result) => result.data.isNotEmpty)) return results;

    if (firstError != null) throw firstError;

    return const [];
  }
}
