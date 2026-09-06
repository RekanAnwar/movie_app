import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/movies_future_provider.dart';

enum HomeMoviesStatus {
  loading,
  hasMovies,
  empty,
}

final homeMoviesStatusProvider = Provider<HomeMoviesStatus>(
  (ref) {
    final asyncValues = MoviesType.values
        .map(
          (moviesType) => ref.watch(
            moviesFutureProvider(
              MoviesFutureProviderParams(
                moviesType: moviesType,
              ),
            ),
          ),
        )
        .toList();

    final isLoading = asyncValues.any(
      (asyncValue) => asyncValue.isLoading && !asyncValue.hasValue,
    );

    if (isLoading) return HomeMoviesStatus.loading;

    final hasMovies = asyncValues.any(
      (asyncValue) => asyncValue.value?.data.isNotEmpty ?? false,
    );

    if (hasMovies) return HomeMoviesStatus.hasMovies;

    return HomeMoviesStatus.empty;
  },
  name: 'homeMoviesStatusProvider',
);
